package main

import (
	"database/sql"
	"delivery/internal/infrastructure/env"
	"delivery/internal/infrastructure/registry"
	"fmt"
	_ "github.com/lib/pq"
	"github.com/pressly/goose/v3"
	"github.com/urfave/cli/v2"
	"go.uber.org/zap"
	"os"
)

func main() {

	// Инициализация контейнера зависимостей
	ctn, _ := registry.NewContainer()
	logger := ctn.Resolve("logger").(*zap.SugaredLogger)

	if err := migration(); err != nil {
		logger.Errorf("migration error: %s", err)
		return
	}
	// Запуск приложения
	app := ctn.Resolve("cli").(*cli.App)
	err := app.Run(os.Args)
	if err != nil {
		panic(err)
	}
	err = ctn.Clean()
	if err != nil {
		panic(err)
	}
}

func migration() error {
	dbDsn := fmt.Sprintf(
		"%s://%s:%s@%s:%s/%s?sslmode=%s&sslrootcert=%s",
		env.DbDriver,
		env.DbUser,
		env.DbPassword,
		env.DbHost,
		env.DbPort,
		env.DbName,
		env.DbSslMode,
		env.DbSslCertPath,
	)

	db, err := sql.Open(env.DbDriver, dbDsn)
	if err != nil {
		return fmt.Errorf("db init error: %w", err)
	}
	defer func() {
		_ = db.Close()
	}()

	if err := goose.SetDialect(env.DbDriver); err != nil {
		return fmt.Errorf("goose init error: %w", err)
	}

	if err := goose.Up(db, "migrations"); err != nil {
		return fmt.Errorf("migrations up error: %w", err)
	}

	return nil
}
