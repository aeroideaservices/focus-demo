package cli

import (
	"delivery/internal/infrastructure/env"
	"github.com/urfave/cli/v2"
)

// ServerHandler Обработчик для команд управления сервисом
type ServerHandler struct {
	server RouterInterface
}

type RouterInterface interface {
	Run(addr ...string) (err error)
}

func NewServerHandler(server RouterInterface) *ServerHandler {
	return &ServerHandler{
		server: server,
	}
}

// Start Запуск сервера
func (h ServerHandler) Start(_ *cli.Context) error {
	err := h.server.Run(env.HTTPPort)
	if err != nil {
		return err
	}
	return nil
}
