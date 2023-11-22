package handler

import (
	"admin-connector/internal/domain/use_case"
	"github.com/aeroideaservices/focus/services/access_control"
	gin_service "github.com/aeroideaservices/focus/services/error_handler/gin"
	"github.com/aeroideaservices/focus/services/errors"
	"github.com/aeroideaservices/focus/services/validation"
	"github.com/gin-gonic/gin"
	"net/http"
)

type ServiceHandler struct {
	servicesUseCase *use_case.ServiceUseCase
	validator       *validation.Validator
	errorHandler    *gin_service.ErrorHandler
}

func NewServiceHandler(
	servicesUseCase *use_case.ServiceUseCase,
	validator *validation.Validator,
	errorHandler *gin_service.ErrorHandler,
) *ServiceHandler {
	return &ServiceHandler{
		servicesUseCase: servicesUseCase,
		validator:       validator,
		errorHandler:    errorHandler,
	}
}

func (h ServiceHandler) GetList(c *gin.Context) {
	dto := use_case.GetServicesListDto{}

	roleInterfaced, ok := c.Get("role")
	if ok {
		dto.Role = roleInterfaced.(*access_control.Role)
	}

	err := h.validator.Validate(c, dto)
	if err != nil {
		h.errorHandler.HandleError(c, errors.BadRequest.Wrap(err, "validation error"))
		return
	}

	c.JSON(http.StatusOK, h.servicesUseCase.GetList(c, dto))
}

func (h ServiceHandler) Get(c *gin.Context) {
	dto := use_case.GetServiceDto{
		ServiceCode: c.Param("serviceCode"),
	}

	roleInterfaced, ok := c.Get("role")
	if ok {
		dto.Role = roleInterfaced.(*access_control.Role)
	}

	err := h.validator.Validate(c, dto)
	if err != nil {
		h.errorHandler.HandleError(c, errors.BadRequest.Wrap(err, "validation error"))
		return
	}

	res, err := h.servicesUseCase.Get(c, dto)
	if err != nil {
		h.errorHandler.HandleError(c, err)
		return
	}

	c.JSON(http.StatusOK, res)
}
