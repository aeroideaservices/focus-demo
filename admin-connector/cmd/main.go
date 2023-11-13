package main

import (
	"admin-connector/internal/adapters/rest"
	"admin-connector/internal/infrastructure/env"
	"admin-connector/internal/infrastructure/registry"
	"go.uber.org/zap"
)

func main() {
	// Инициализация контейнера зависимостей
	ctn, _ := registry.NewContainer()
	defer func(ctn *registry.Container) { _ = ctn.Clean() }(ctn)

	server := ctn.Resolve("router").(*rest.Router)
	log := ctn.Resolve("logger").(*zap.SugaredLogger)
	router := server.Router()
	err := router.Run(env.HttpPort)
	if err != nil {
		log.Fatal(err)
	}
}
