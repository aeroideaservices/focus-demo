package handlers

import (
	"demo/internal/adapters/websockets"
	"github.com/aeroideaservices/focus/services/errors"
	"github.com/gin-gonic/gin"
)

type WebsocketsHandler struct {
	websockets *websockets.Websockets
}

func NewWebsocketsHandler(websockets *websockets.Websockets) *WebsocketsHandler {
	return &WebsocketsHandler{websockets: websockets}
}

func (r *WebsocketsHandler) Subscribe(c *gin.Context) {
	userId := c.GetHeader("User-Id")
	if userId == "" {
		_ = c.Error(errors.BadRequest.New("user-id param is required"))
		return
	}

	if err := r.websockets.Subscribe(c.Writer, c.Request, userId); err != nil {
		_ = c.Error(err)
	}
}
