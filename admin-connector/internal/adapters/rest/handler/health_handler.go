package handler

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type HealthHandler struct {
}

func (h HealthHandler) Health(c *gin.Context) {
	adminRoute := c.GetString("adminRoute")
	if adminRoute != "/health/check" {
		c.Next()
	}
	c.JSON(http.StatusOK, gin.H{"status": "ok"})
}
