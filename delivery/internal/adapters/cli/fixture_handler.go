package cli_handlers

import (
	"delivery/internal/service/fixtures"
	"github.com/urfave/cli/v2"
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
