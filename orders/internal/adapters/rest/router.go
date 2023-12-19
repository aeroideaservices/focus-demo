package rest

import (
	confRest "github.com/aeroideaservices/focus/configurations/rest"
	"github.com/aeroideaservices/focus/menu/rest"
	"net/http"
	"orders/internal/adapters/rest/handlers"

	"github.com/gin-gonic/gin"

	mediaRest "github.com/aeroideaservices/focus/media/rest"
	modelsRest "github.com/aeroideaservices/focus/models/rest"
	middleware "github.com/aeroideaservices/focus/services/gin-middleware"
)

type Router struct {
	ginMode                   string
	apiSettings               APISettings
	fixturesHandler           *handlers.FixturesHandler
	optionsHandler            *handlers.OptionsHandler
	focusConfigurationsRouter *confRest.Router
	focusMediaRouter          *mediaRest.Router
	focusMenuRouter           *rest.Router
	focusModelsRouter         *modelsRest.Router
	errorHandler              *middleware.ErrorHandler
}

type APISettings struct {
	Root        string
	Version     string
	ServiceName string
	FocusPath   string
}

func NewRouter(
	ginMode string,
	apiSettings APISettings,
	fixturesHandler *handlers.FixturesHandler,
	optionsHandler *handlers.OptionsHandler,
	focusConfigurationsRouter *confRest.Router,
	focusMediaRouter *mediaRest.Router,
	focusMenuRouter *rest.Router,
	focusModelsRouter *modelsRest.Router,
	errorHandler *middleware.ErrorHandler,
) *Router {
	return &Router{
		ginMode:                   ginMode,
		apiSettings:               apiSettings,
		fixturesHandler:           fixturesHandler,
		optionsHandler:            optionsHandler,
		focusConfigurationsRouter: focusConfigurationsRouter,
		focusMediaRouter:          focusMediaRouter,
		focusMenuRouter:           focusMenuRouter,
		focusModelsRouter:         focusModelsRouter,
		errorHandler:              errorHandler,
	}
}

func (r Router) Router() *gin.Engine {
	gin.SetMode(r.ginMode)
	router := gin.New()
	// обработка ошибок page not found и method not allowed
	router.NoRoute(func(c *gin.Context) {
		c.JSON(http.StatusNotFound, gin.H{"applicationErrorCode": http.StatusText(http.StatusNotFound), "message": "page not found"})
	})
	router.NoMethod(func(c *gin.Context) {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"applicationErrorCode": http.StatusText(http.StatusMethodNotAllowed), "message": "method not allowed"})
	})

	healthCheck := func(c *gin.Context) { c.JSON(http.StatusOK, gin.H{"status": "ok"}) }

	api := router.Group(r.apiSettings.Root)
	v1 := api.Group(r.apiSettings.Version)

	// internal
	service := v1.Group(r.apiSettings.ServiceName)
	service.Use(r.errorHandler.Handle)
	service.Group("health").Group("check").GET("", healthCheck)

	fixtures := service.Group("fixtures")
	fixtures.POST("run", r.fixturesHandler.RunFixtures)

	configurationsRoutes := service.Group("configurations")
	confRoutes := configurationsRoutes.Group(":configuration-code")
	optRoutes := confRoutes.Group("options")
	optRoutes.GET("", r.optionsHandler.List)

	// cms focus
	focus := v1.Group(r.apiSettings.FocusPath)
	focus.Group("health").Group("check").GET("", healthCheck)
	r.focusConfigurationsRouter.SetRoutes(focus)
	r.focusMediaRouter.SetRoutes(focus)
	r.focusMenuRouter.SetRoutes(focus)
	r.focusModelsRouter.SetRoutes(focus)

	return router
}
