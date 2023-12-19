package handlers

import (
	"github.com/aeroideaservices/focus/configurations/plugin/actions"
	"github.com/aeroideaservices/focus/services/validation"
	"github.com/gin-gonic/gin"
	"net/http"
	tracerAdapter "orders/internal/service/utils/tracer"
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
	tracer := tracerAdapter.NewTracer("OptionsHandler::List")
	defer tracer.Close()

	dto := actions.ListOptionsPreviews{
		ConfCode: c.Param("configuration-code"),
		OptCodes: c.QueryArray("optionsCodes"),
	}
	tracer.LogData("request", dto)

	err := h.validator.Validate(c, dto)
	if err != nil {
		tracer.LogError(err)
		_ = c.Error(err)
		return
	}

	options, err := h.options.ListPreviews(c, dto)
	if err != nil {
		tracer.LogError(err)
		_ = c.Error(err)
		return
	}

	tracer.LogData("response", options)
	c.JSON(http.StatusOK, options)
}
