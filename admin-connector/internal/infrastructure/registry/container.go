package registry

import (
	"admin-connector/internal/adapters/http/services"
	"admin-connector/internal/adapters/rest"
	"admin-connector/internal/adapters/rest/handler"
	"admin-connector/internal/adapters/rest/middleware"
	"admin-connector/internal/domain/entity"
	"admin-connector/internal/domain/use_case"
	"admin-connector/internal/infrastructure/env"
	"fmt"
	"github.com/aeroideaservices/focus/services/access_control"
	"github.com/aeroideaservices/focus/services/error_handler/gin"
	"github.com/aeroideaservices/focus/services/gin_middleware"
	"github.com/aeroideaservices/focus/services/translator"
	"github.com/aeroideaservices/focus/services/validation"
	gin2 "github.com/gin-gonic/gin"
	"github.com/go-playground/locales/en"
	"github.com/go-playground/locales/ru"
	ut "github.com/go-playground/universal-translator"
	"github.com/sarulabs/di/v2"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"golang.org/x/exp/maps"
	"golang.org/x/text/language"
	"golang.org/x/text/message"
	"strings"
)

type Container struct {
	ctn di.Container
}

func NewContainer() (*Container, error) {
	builder, err := di.NewBuilder()
	if err != nil {
		return nil, err
	}

	if err = builder.Add(definitions...); err != nil {
		return nil, err
	}
	if err = builder.Add(access_control.Definitions...); err != nil {
		return nil, err
	}

	return &Container{
		ctn: builder.Build(),
	}, nil
}

var definitions = []di.Def{
	{
		Build: func(ctn di.Container) (interface{}, error) {
			restMiddleware := ctn.Get("restMiddleware").(*middleware.RedirectMiddleware)
			accessMiddleware := ctn.Get("focus.accessMiddleware").(*access_control.AccessMiddleware)
			serviceHandler := ctn.Get("serviceHandler").(*handler.ServiceHandler)
			privilegesHandler := ctn.Get("privilegesHandler").(*handler.PrivilegesHandler)
			errorService := ctn.Get("errorHandler").(*gin.ErrorHandler)
			errorHandler := ctn.Get("focus.errorHandler").(*gin_middleware.ErrorHandler)
			logger := ctn.Get("logger").(*zap.SugaredLogger)
			healthHandler := &handler.HealthHandler{}
			return rest.NewRouter(
				healthHandler,
				serviceHandler,
				privilegesHandler,
				restMiddleware,
				accessMiddleware,
				errorService,
				errorHandler,
				logger,
			), nil
		},
		Name:     "router",
		Tags:     nil,
		Unshared: false,
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			logLevel := zap.NewAtomicLevel()
			_ = logLevel.UnmarshalText([]byte(env.LogLevel))
			var config = zap.Config{
				Level:            logLevel,
				Encoding:         "json",
				OutputPaths:      []string{"stdout"},
				ErrorOutputPaths: []string{"stderr"},
				EncoderConfig: zapcore.EncoderConfig{
					MessageKey:  "message",
					LevelKey:    "level",
					EncodeLevel: zapcore.LowercaseLevelEncoder,
				},
			}
			logger, err := config.Build()
			if err != nil {
				return nil, err
			}

			logger.Debug("logger construction succeeded")
			return logger.Sugar(), nil
		},
		Name: "logger",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			logger := ctn.Get("logger").(*zap.SugaredLogger)
			return gin.NewErrorHandler(logger), nil
		},
		Name: "errorHandler",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			ps := ctn.Get("pluginsServices").(map[string][]entity.Service)
			pluginsServices := middleware.PluginsServices{}
			for plugin, services := range ps {
				pluginsServices[plugin] = make(map[string]string)
				for _, service := range services {
					pluginsServices[plugin][service.Code] = service.Endpoint.String()
				}
			}
			endpoint := fmt.Sprintf("/%s/%s/%s", env.HttpApiRoot, env.HttpApiVersion, env.HttpApiServiceName)
			errorHandler := ctn.Get("errorHandler").(*gin.ErrorHandler)
			servicesChecker := ctn.Get("servicesChecker").(*services.ServicesChecker)
			logger := ctn.Get("logger").(*zap.SugaredLogger)
			return middleware.NewRedirectMiddleware(endpoint, errorHandler, pluginsServices, servicesChecker, logger), nil
		},
		Name: "restMiddleware",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			return map[string][]entity.Service{
				"configurations": env.ConfigurationsServices,
				"forms":          env.FormServices,
				"mail-templates": env.MailTemplatesServices,
				"media":          env.MediaServices,
				"menus":          env.MenuServices,
				"models":         env.ModelsServices,
				"models-v2":      env.ModelsV2Services,
				"reviews":        env.ReviewsServices,
			}, nil
		},
		Name: "pluginsServices",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			pluginsServices := ctn.Get("pluginsServices").(map[string][]entity.Service)
			var attachedServices = make(map[entity.Service]bool, 0)

			for _, services := range pluginsServices {
				for _, service := range services {
					attachedServices[service] = true
				}
			}

			return maps.Keys(attachedServices), nil
		},
		Name: "attachedServices",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			attachedServices := ctn.Get("attachedServices").([]entity.Service)
			logger := ctn.Get("logger").(*zap.SugaredLogger)
			servicesChecker := services.NewServicesChecker(attachedServices, logger)
			servicesChecker.CheckAll()
			return servicesChecker, nil
		},
		Name: "servicesChecker",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			serviceUseCase := ctn.Get("serviceUseCase").(*use_case.ServiceUseCase)
			validator := ctn.Get("validator").(*validation.Validator)
			errorHandler := ctn.Get("errorHandler").(*gin.ErrorHandler)
			return handler.NewServiceHandler(serviceUseCase, validator, errorHandler), nil
		},
		Name: "serviceHandler",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			errorHandler := ctn.Get("errorHandler").(*gin.ErrorHandler)
			accessControl := ctn.Get("focus.accessControl").(*access_control.AccessControl)
			return handler.NewPrivilegesHandler(errorHandler, accessControl), nil
		},
		Name: "privilegesHandler",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			universalTranslator := ctn.Get("universalTranslator").(*ut.UniversalTranslator)
			return validation.NewValidator(universalTranslator), nil
		},
		Name: "validator",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			pluginsServices := ctn.Get("pluginsServices").(map[string][]entity.Service)
			servicesMap := make(map[entity.Service]bool)
			for _, services := range pluginsServices {
				for _, service := range services {
					servicesMap[service] = true
				}
			}
			servicesChecker := ctn.Get("servicesChecker").(*services.ServicesChecker)
			return use_case.NewServiceUseCase(pluginsServices, maps.Keys(servicesMap), servicesChecker), nil
		},
		Name: "serviceUseCase",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			baseURI := fmt.Sprintf("/%s/%s/%s", env.HttpApiRoot, env.HttpApiVersion, env.HttpApiServiceName)

			return baseURI, nil
		},
		Name: "baseURI",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			baseURI := ctn.Get("baseURI").(string)

			return access_control.CreateActionRule(func(c *gin2.Context) *access_control.Action {
				route := strings.TrimPrefix(c.Request.URL.Path, baseURI)
				if strings.HasPrefix(route, "/services") {
					return access_control.NewAction("services", c.Request.Method)
				}

				return access_control.NewAction(c.GetHeader(middleware.ServiceCodeHeader)+route, c.Request.Method)
			}), nil
		},
		Name: "focus.access.createActionRule",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			return fmt.Sprintf("-----BEGIN PUBLIC KEY-----\n%s\n-----END PUBLIC KEY-----", env.KeyCloakCert), nil
		},
		Name: "focus.access.jwtRSACert",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			logger := ctn.Get("logger").(*zap.SugaredLogger)
			translator := ctn.Get("focus.errorTranslator").(*translator.ErrorTranslator)
			return gin_middleware.NewErrorHandler(translator, logger), nil
		},
		Name: "focus.errorHandler",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			defaultTranslator := ctn.Get("translator").(*translator.Translator)
			universalTranslator := ctn.Get("universalTranslator").(*ut.UniversalTranslator)
			return translator.NewErrorTranslator(defaultTranslator, universalTranslator), nil
		},
		Name: "focus.errorTranslator",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			english := en.New()
			russian := ru.New()
			return ut.New(russian, russian, english), nil
		},
		Name: "universalTranslator",
	},
	{
		Build: func(ctn di.Container) (interface{}, error) {
			rus := message.NewPrinter(language.Russian)
			eng := message.NewPrinter(language.English)

			translationsMap := map[string]*message.Printer{
				language.Russian.String(): rus,
				language.English.String(): eng,
			}
			return translator.NewTranslator(translationsMap, rus), nil
		},
		Name: "translator",
	},
}

// Получение зависимости из контейнера
func (c *Container) Resolve(name string) interface{} {
	return c.ctn.Get(name)
}

// Очистка контейнера
func (c *Container) Clean() error {
	return c.ctn.Clean()
}
