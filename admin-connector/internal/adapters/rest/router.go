package rest

import (
	"admin-connector/internal/adapters/rest/handler"
	"admin-connector/internal/adapters/rest/middleware"
	"admin-connector/internal/infrastructure/env"
	"github.com/aeroideaservices/focus/services/access_control"
	ginService "github.com/aeroideaservices/focus/services/error_handler/gin"
	"github.com/aeroideaservices/focus/services/errors"
	gin_middleware "github.com/aeroideaservices/focus/services/gin-middleware"
	"github.com/gin-contrib/timeout"
	ginzap "github.com/gin-contrib/zap"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"strings"
	"time"
)

type Router struct {
	healthHandler      *handler.HealthHandler
	serviceHandler     *handler.ServiceHandler
	privilegesHandler  *handler.PrivilegesHandler
	redirectMiddleware *middleware.RedirectMiddleware
	accessMiddleware   *access_control.AccessMiddleware
	errorService       *ginService.ErrorHandler
	errorHandler       *gin_middleware.ErrorHandler
	logger             *zap.SugaredLogger
}

func NewRouter(
	healthHandler *handler.HealthHandler,
	serviceHandler *handler.ServiceHandler,
	privilegesHandler *handler.PrivilegesHandler,
	redirectMiddleware *middleware.RedirectMiddleware,
	accessMiddleware *access_control.AccessMiddleware,
	errorService *ginService.ErrorHandler,
	errorHandler *gin_middleware.ErrorHandler,
	logger *zap.SugaredLogger,
) *Router {
	return &Router{
		healthHandler:      healthHandler,
		serviceHandler:     serviceHandler,
		privilegesHandler:  privilegesHandler,
		redirectMiddleware: redirectMiddleware,
		accessMiddleware:   accessMiddleware,
		errorService:       errorService,
		errorHandler:       errorHandler,
		logger:             logger,
	}
}

func (r Router) requestTimeoutResponse(c *gin.Context) {
	r.errorService.HandleError(c, errors.RequestTimeout.New("request timeout"))
}

func (r Router) Router() *gin.Engine {
	gin.SetMode(env.GinMode)
	router := gin.New()

	timeoutMiddleware := func(c *gin.Context) {
		if !strings.HasSuffix(c.Request.RequestURI, "/wss") {
			timeout.New( // request timeout
				timeout.WithTimeout(time.Second*time.Duration(env.RequestTimeout)),
				timeout.WithHandler(func(c *gin.Context) { c.Next() }),
				timeout.WithResponse(r.requestTimeoutResponse),
			)(c)
		} else {
			c.Next()
		}
	}

	router.Use(
		ginzap.Ginzap(r.logger.Desugar(), time.RFC3339, true), // logger
		timeoutMiddleware,
		r.errorHandler.Handle,
	)

	v1 := router.Group(env.HttpApiRoot).Group(env.HttpApiVersion)
	v1.GET("/health/check", r.healthHandler.Health)
	service := v1.Group(env.HttpApiServiceName)
	service.Group("errors").GET("500", func(c *gin.Context) { r.errorService.HandleError(c, errors.NoType.New("test 500 error")) })

	router.NoRoute(r.accessMiddleware.CheckAccess, r.redirectMiddleware.Redirect)

	service.GET("/wss", r.accessMiddleware.CheckAccess, r.serviceHandler.WSS)

	servicesGroup := service.Group("services", r.accessMiddleware.CheckAccess)
	servicesGroup.GET("", r.serviceHandler.GetList)
	servicesGroup.GET(":serviceCode", r.serviceHandler.Get)

	privilegesGroup := service.Group("privileges", r.accessMiddleware.CheckAccess)
	privilegesGroup.POST("check", r.privilegesHandler.Check)

	return router
}
