package handlers

import (
	"delivery/internal/service/fixtures"
	"github.com/gin-gonic/gin"
	"net/http"
)

type FixturesHandler struct {
	fixtureService *fixtures.FixtureService
}

func NewFixturesHandler(
	fixtureService *fixtures.FixtureService,
) *FixturesHandler {
	return &FixturesHandler{
		fixtureService: fixtureService,
	}
}

func (h FixturesHandler) RunFixtures(c *gin.Context) {
	if err := h.fixtureService.RunFixtures(c); err != nil {
		_ = c.Error(err)
		return
	}

	c.JSON(http.StatusOK, gin.H{"succeed": true})
}
