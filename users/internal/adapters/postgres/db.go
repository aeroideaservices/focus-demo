package postgres

import (
	extraClausePlugin "github.com/WinterYukky/gorm-extra-clause-plugin"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"os"
	"strconv"
)

// Конструктор
func NewDatabase(dsn string) (*gorm.DB, error) {
	var loggerObj logger.Interface
	logmode, err := strconv.ParseBool(os.Getenv("DB_LOGMODE"))
	if err != nil {
		return nil, err
	}
	if logmode {
		loggerObj = logger.Default.LogMode(logger.Info)
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: loggerObj,
	})
	if err != nil {
		return nil, err
	}

	err = db.Use(extraClausePlugin.New())
	if err != nil {
		return nil, err
	}

	return db, nil
}
