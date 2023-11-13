package handler

import (
	"github.com/aeroideaservices/focus/services/access_control"
	ginService "github.com/aeroideaservices/focus/services/error_handler/gin"
	"github.com/aeroideaservices/focus/services/errors"
	"github.com/gin-gonic/gin"
	"net/http"
	"strings"
)

type PrivilegesHandler struct {
	errorHandler  *ginService.ErrorHandler
	accessControl *access_control.AccessControl
}

func NewPrivilegesHandler(
	errorHandler *ginService.ErrorHandler,
	accessControl *access_control.AccessControl,
) *PrivilegesHandler {
	return &PrivilegesHandler{
		errorHandler:  errorHandler,
		accessControl: accessControl,
	}
}

func (h PrivilegesHandler) Check(c *gin.Context) {
	tokenString := strings.TrimPrefix(c.GetHeader("Authorization"), "Bearer ")
	if tokenString == "" {
		h.errorHandler.HandleError(c, errors.Unauthorized.New("auth required"))
		return
	}

	body := struct {
		Privilege string `json:"privilege"`
	}{}
	if err := c.BindJSON(&body); err != nil {
		h.errorHandler.HandleError(c, errors.BadRequest.Wrap(err, "error parsing json"))
		return
	}
	action := access_control.NewAction(body.Privilege, "")
	if err := h.accessControl.CheckAccess(tokenString, action); err != nil {
		h.errorHandler.HandleError(c, err)
		return
	}

	c.Status(http.StatusNoContent)
}
