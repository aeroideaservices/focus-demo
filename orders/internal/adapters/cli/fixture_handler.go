package cli_handlers

import (
	"github.com/urfave/cli/v2"
	"orders/internal/service/fixtures"
)

type FixtureHandler struct {
	fixtureService *fixtures.FixtureService
}

func NewFixtureHandler(fixtureService *fixtures.FixtureService) *FixtureHandler {
	return &FixtureHandler{fixtureService: fixtureService}
}

func (h FixtureHandler) RunFixtures(ctx *cli.Context) error {
	return h.fixtureService.RunFixtures(ctx.Context)
}
