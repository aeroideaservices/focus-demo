package handlers

import (
	"github.com/aeroideaservices/focus/configurations/plugin/actions"
	"github.com/aeroideaservices/focus/services/validation"
	"github.com/gin-gonic/gin"
	"net/http"
)

type OptionsHandler struct {
	options   *actions.Options
	validator *validation.Validator
}

func NewOptionsHandler(
	options *actions.Options,
	validator *validation.Validator,
) *OptionsHandler {
	return &OptionsHandler{
		options:   options,
		validator: validator,
	}
}

func (h OptionsHandler) List(c *gin.Context) {
	dto := actions.ListOptionsPreviews{
		ConfCode: c.Param("configuration-code"),
		OptCodes: c.QueryArray("optionsCodes"),
	}
	err := h.validator.Validate(c, dto)
	if err != nil {
		_ = c.Error(err)
		return
	}
	options, err := h.options.ListPreviews(c, dto)
	if err != nil {
		_ = c.Error(err)
		return
	}
	c.JSON(http.StatusOK, options)
}
