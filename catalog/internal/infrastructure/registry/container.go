package registry

import (
	entity "catalog/internal/domain/entitiy"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/sarulabs/di/v2"
	"github.com/urfave/cli/v2"
	"os"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"go.uber.org/zap"
	"gorm.io/gorm"

	confRest "github.com/aeroideaservices/focus/configurations/rest"
	mediaRest "github.com/aeroideaservices/focus/media/rest"
	menuRest "github.com/aeroideaservices/focus/menu/rest"
	modelsRest "github.com/aeroideaservices/focus/models/rest"
	middleware "github.com/aeroideaservices/focus/services/gin-middleware"

	cliHandlers "catalog/internal/adapters/cli"
	"catalog/internal/adapters/postgres"
	"catalog/internal/adapters/rest"
	"catalog/internal/adapters/rest/handlers"
	"catalog/internal/infrastructure/env"
	"catalog/internal/infrastructure/registry/services_definitions"
	"catalog/internal/service/fixtures"
)

type Container struct {
	ctn di.Container
}

// NewContainer конструктор контейнера
func NewContainer() (*Container, error) {
	builder, err := di.NewBuilder()
	if err != nil {
		return nil, err
	}
	if err = builder.Add(definitions...); err != nil {
		return nil, err
	}

	if err = builder.Add(services_definitions.FocusDefinitions...); err != nil {
		return nil, err
	}

	if err = builder.Add(services_definitions.ConfigurationsDefinitions...); err != nil {
		return nil, err
	}

	if err = builder.Add(services_definitions.MediaDefinitions...); err != nil {
		return nil, err
	}

	if err = builder.Add(services_definitions.MenuDefinitions...); err != nil {
		return nil, err
	}

	if err = builder.Add(services_definitions.ModelsDefinitions...); err != nil {
		return nil, err
	}

	return &Container{
		ctn: builder.Build(),
	}, nil
}

// Resolve Получение зависимости из контейнера
func (c *Container) Resolve(name string) interface{} {
	return c.ctn.Get(name)
}

// Clean Очистка контейнера
func (c *Container) Clean() error {
	return c.ctn.Clean()
}

var definitions = []di.Def{
	{
		Name: "logger",
		Build: func(ctn di.Container) (interface{}, error) {
			rawJSON := []byte(`{
				  "level": "` + env.LogLevel + `",
				  "encoding": "json",
				  "outputPaths": ["stdout"],
				  "errorOutputPaths": ["stderr"],
				  "encoderConfig": {
					"messageKey": "message",
					"levelKey": "level",
					"levelEncoder": "lowercase"
				  }
				}`)
			var cfg zap.Config
			if err := json.Unmarshal(rawJSON, &cfg); err != nil {
				return nil, err
			}
			logger, err := cfg.Build()
			if err != nil {
				return nil, err
			}
			logger.Debug("logger construction succeeded")
			sugar := logger.Sugar()
			return sugar, nil
		},
	},
	{
		Name: "db", // Database
		Build: func(ctn di.Container) (interface{}, error) {
			logger := ctn.Get("logger").(*zap.SugaredLogger)

			conn := fmt.Sprintf("host=%s port=%s dbname=%s user=%s sslmode=%s",
				env.DbHost, env.DbPort, env.DbName, env.DbUser, env.DbSslMode)

			c1 := make(chan *gorm.DB, 1)
			go func() {
				// Получение лог-сервиса из контейнера
				logger.Info("Try to connect to database")

				_, err := os.ReadFile(env.DbSslCertPath)
				if env.DbSslMode != "disable" && env.DbSslCertPath != "" && err != nil {
					logger.Fatal("cannot open cert file")
				}

				// dsn
				dsn := conn + " sslrootcert=" + env.DbSslCertPath + " password=" + env.DbPassword
				dbConn, err := postgres.NewDatabase(dsn)
				if err != nil {
					logger.Error(fmt.Sprintf("DB error connection. Details: %s", err))
					logger.Fatal(fmt.Sprintf("DB error connection. Connection data: %s", conn))
					c1 <- nil
					return
				} else if dbConn != nil {
					logger.Info("DB connection has  been successfully created")
				}
				c1 <- dbConn
			}()

			// Listen on our channel AND a timeout channel - which ever happens first.
			select {
			case db := <-c1:
				_ = db.AutoMigrate(
					&entity.Brand{},
					&entity.Model{},
				)
				return db, nil
			case <-time.After(30 * time.Second):
				err := errors.New("5 seconds timeout error")
				logger.Error(fmt.Sprintf("DB error connection. Details: %s", err))
				logger.Error(fmt.Sprintf("DB error connection. Connection data: %s", conn))
				return nil, err
			}
		},
	},
	{
		Name: "router",
		Build: func(ctn di.Container) (interface{}, error) {
			logger := ctn.Get("logger").(*zap.SugaredLogger)
			logger.Info("building router")
			fixturesHandler := ctn.Get("fixturesHandler").(*handlers.FixturesHandler)
			optionsHandler := ctn.Get("optionsHandler").(*handlers.OptionsHandler)
			focusConfigurationsRouter := ctn.Get("focus.configurations.router").(*confRest.Router)
			focusMediaRouter := ctn.Get("focus.media.router").(*mediaRest.Router)
			focusMenuRouter := ctn.Get("focus.menu.router").(*menuRest.Router)
			focusModelsRouter := ctn.Get("focus.models.router").(*modelsRest.Router)
			errorHandler := ctn.Get("focus.errorHandler").(*middleware.ErrorHandler)
			router := rest.NewRouter(
				env.GinMode,
				rest.APISettings{
					Root:        env.HTTPApiRoot,
					Version:     env.HTTPApiVersion,
					ServiceName: env.HTTPApiServiceName,
					FocusPath:   env.HTTPApiFocusPath,
				},
				fixturesHandler,
				optionsHandler,
				focusConfigurationsRouter,
				focusMediaRouter,
				focusMenuRouter,
				focusModelsRouter,
				errorHandler,
			)
			logger.Info("router has built")
			return router, nil
		},
	},
	{ // AWS S3 client
		Name: "awsS3.client",
		Build: func(ctn di.Container) (interface{}, error) {
			cfg := aws.Config{
				Region:      env.AwsRegion,
				Credentials: credentials.NewStaticCredentialsProvider(env.AwsAccessKeyID, env.AwsSecretAccessKey, ""),
				EndpointResolverWithOptions: aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
					if service == s3.ServiceID {
						return aws.Endpoint{
							PartitionID:       "aws",
							URL:               env.AwsEndpoint,
							SigningRegion:     env.AwsRegion,
							HostnameImmutable: true,
						}, nil
					}
					return aws.Endpoint{}, &aws.EndpointNotFoundError{}
				}),
			}
			client := s3.NewFromConfig(cfg)
			return client, nil
		},
	},
	{ // AWS S3 client
		Name: "awsS3.bucketName",
		Build: func(ctn di.Container) (interface{}, error) {
			return env.AwsBucket, nil
		},
	},
	{
		Name: "cli",
		Build: func(ctn di.Container) (interface{}, error) {
			app := cli.NewApp()
			fixturesService := ctn.Get("fixturesService").(*fixtures.FixtureService)
			fixtureHandler := cliHandlers.NewFixtureHandler(fixturesService)

			app.Usage = "collection of workers"
			app.Commands = []*cli.Command{
				{
					Name:   "run_fixtures",
					Usage:  "This command runs fixtures",
					Action: fixtureHandler.RunFixtures,
				},
			}
			return app, nil
		},
	},
	{
		Name: "fixtures",
		Build: func(ctn di.Container) (interface{}, error) {
			return []fixtures.Fixture{
				fixtures.ProductFixture{},
				fixtures.StoreFixture{},
				fixtures.PromoFixture{},
				fixtures.ConfigurationFixture{},
				fixtures.OptionFixture{},
			}, nil
		},
	},
	{
		Name: "fixturesService",
		Build: func(ctn di.Container) (interface{}, error) {
			f := ctn.Get("fixtures").([]fixtures.Fixture)
			fr := ctn.Get("fixtureRepository").(fixtures.FixtureRepository)
			return fixtures.NewFixtureService(f, fr), nil
		},
	},
	{
		Name: "fixtureRepository",
		Build: func(ctn di.Container) (interface{}, error) {
			db := ctn.Get("db").(*gorm.DB)
			return postgres.NewFixtureRepository(db), nil
		},
	},
	{
		Name: "fixturesHandler",
		Build: func(ctn di.Container) (interface{}, error) {
			fixtureService := ctn.Get("fixturesService").(*fixtures.FixtureService)
			return handlers.NewFixturesHandler(fixtureService), nil
		},
	},
}
