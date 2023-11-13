package middleware

import (
	"admin-connector/internal/adapters/http/services"
	"encoding/json"
	gin_service "github.com/aeroideaservices/focus/services/error_handler/gin"
	"github.com/aeroideaservices/focus/services/errors"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"io"
	"net/http"
	"strings"
)

const ServiceCodeHeader = "Service-Code"

type PluginsServices = map[string]ServicesEndpoints
type ServicesEndpoints map[string]string

type RedirectMiddleware struct {
	endpoint        string // Эндпоинт сервиса
	errorHandler    *gin_service.ErrorHandler
	pluginsServices PluginsServices
	servicesChecker *services.ServicesChecker
	logger          *zap.SugaredLogger
}

func NewRedirectMiddleware(
	endpoint string,
	errorHandler *gin_service.ErrorHandler,
	pluginsServices PluginsServices,
	servicesChecker *services.ServicesChecker,
	logger *zap.SugaredLogger,
) *RedirectMiddleware {
	return &RedirectMiddleware{
		endpoint:        endpoint,
		errorHandler:    errorHandler,
		pluginsServices: pluginsServices,
		servicesChecker: servicesChecker,
		logger:          logger,
	}
}

func (m RedirectMiddleware) Redirect(c *gin.Context) {
	if len(c.Errors) != 0 {
		return
	}

	// создаем запрос к сервису
	request, err := m.getRedirectRequest(c)
	if err != nil {
		m.errorHandler.HandleError(c, errors.BadRequest.Wrap(err, "error creating new request"))
		return
	}
	defer func() { _ = request.Close }()

	// делаем запрос к сервису
	response, err := http.DefaultClient.Do(request)
	if err != nil {
		m.errorHandler.HandleError(c, errors.BadRequest.Wrap(err, "error sending request"))
		return
	}
	defer func() { _ = response.Close }()

	err = m.setRedirectResponse(c, response)
	if err != nil {
		m.errorHandler.HandleError(c, err)
	}
}

func (m RedirectMiddleware) getRedirectRequest(c *gin.Context) (*http.Request, error) {
	route := c.Request.URL.Path
	adminRoute := strings.TrimPrefix(route, m.endpoint)
	split := strings.SplitN(strings.TrimLeft(adminRoute, "/"), "/", 2)

	if len(split) == 0 {
		return nil, errors.BadRequest.New("wrong uri")
	}
	pluginCode := strings.SplitN(strings.TrimLeft(adminRoute, "/"), "/", 2)[0]

	// проверяем, существует ли такой плагин
	if _, ok := m.pluginsServices[pluginCode]; !ok {
		return nil, errors.NotFound.Newf("plugin '%s' not found", pluginCode)
	}
	pluginServices := m.pluginsServices[pluginCode]

	serviceCode := c.GetHeader(ServiceCodeHeader)
	if serviceCode == "" {
		return nil, errors.BadRequest.Newf("%s header is required", ServiceCodeHeader)
	}
	// проверяем, есть ли сервис в списке
	serviceEndpoint, ok := pluginServices[serviceCode]
	if !ok {
		return nil, errors.NotFound.Newf("plugin '%s' is not supported by service '%s'", pluginCode, serviceCode)
	}
	// проверяем доступность сервиса
	err := m.servicesChecker.CheckServiceAvailability(serviceCode)
	if err != nil {
		return nil, err
	}

	// получаем текущий URL
	requestUrl := c.Request.URL.Path
	// меняем эндпоинт на эндпоинт сервиса
	requestUrl = strings.Replace(requestUrl, m.endpoint, serviceEndpoint, 1)
	redirectURL, err := c.Request.URL.Parse(requestUrl)
	if err != nil {
		return nil, errors.NoType.Wrap(err, "error parsing url")
	}
	redirectURL.RawQuery = c.Request.URL.RawQuery

	// создаем запрос к сервису
	request, err := http.NewRequestWithContext(c, c.Request.Method, redirectURL.String(), c.Request.Body)
	defer func() { _ = request.Close }()
	if err != nil {
		return nil, errors.BadRequest.Wrap(err, "error creating new request")
	}
	request.Header = c.Request.Header
	request.Header.Set("User-Id", c.GetString("user-id"))
	request.Header.Set("User-Full-Name", c.GetString("user-full-name"))

	return request, nil
}

func (m RedirectMiddleware) setRedirectResponse(c *gin.Context, response *http.Response) error {
	// читаем ответ запроса к сервису
	reader := response.Body
	responseBodyBytes, err := io.ReadAll(reader)
	if err != nil {
		return errors.BadRequest.Wrap(err, "error reading response")
	}

	// проставляем заголовки
	for key := range response.Header {
		c.Header(key, response.Header.Get(key))
	}
	var responseBody = any(nil)
	if len(responseBodyBytes) == 0 {
		c.Status(response.StatusCode)
		return nil
	}

	err = json.Unmarshal(responseBodyBytes, &responseBody)
	if err != nil {
		return errors.BadRequest.Wrap(err, "error parsing response json")
	}

	c.JSON(response.StatusCode, responseBody)
	return nil
}
