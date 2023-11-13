package handler

import (
	"admin-connector/internal/adapters/rest/middleware"
	"admin-connector/internal/domain/use_case"
	"crypto/tls"
	"github.com/aeroideaservices/focus/services/access_control"
	gin_service "github.com/aeroideaservices/focus/services/error_handler/gin"
	"github.com/aeroideaservices/focus/services/errors"
	"github.com/aeroideaservices/focus/services/validation"
	"github.com/gin-gonic/gin"
	"net"
	"net/http"
	"net/http/httputil"
	"net/url"
	"time"
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

func (h ServiceHandler) WSS(c *gin.Context) {
	dto := use_case.GetServiceDto{
		ServiceCode: c.GetHeader(middleware.ServiceCodeHeader),
	}

	service, err := h.servicesUseCase.GetEndpoint(c, dto)
	if err != nil {
		h.errorHandler.HandleError(c, err)
		return
	}

	wssUrl, err := url.ParseRequestURI(service.Endpoint.String() + "/wss")
	if err != nil {
		h.errorHandler.HandleError(c, errors.NoType.Wrap(err, "error parsing uri"))
		return
	}

	director := func(req *http.Request) {
		req.URL = wssUrl
		req.Header.Set("User-Id", c.GetString("user-id"))
		req.Header.Set("User-Full-Name", c.GetString("user-full-name"))
	}
	dialer := &net.Dialer{
		KeepAlive: 30 * time.Second,
	}
	proxy := &httputil.ReverseProxy{Director: director, Transport: &http.Transport{
		Proxy:               http.ProxyFromEnvironment,
		DialContext:         dialer.DialContext,
		TLSHandshakeTimeout: 10 * time.Second,
		TLSClientConfig:     &tls.Config{InsecureSkipVerify: true},
	}}
	proxy.ServeHTTP(c.Writer, c.Request)
}
