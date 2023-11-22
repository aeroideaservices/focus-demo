package env

import (
	"admin-connector/internal/domain/entity"
	"fmt"
	"github.com/gin-gonic/gin"
	"net/url"
	"os"
	"strconv"
	"strings"
)

var (
	LogLevel           = Getter("LOG_LEVEL", "debug")
	HttpPort           = fmt.Sprintf(":%s", Getter("HTTP_PORT", "8080"))
	HttpApiRoot        = Getter("HTTP_API_ROOT", "api")
	HttpApiVersion     = Getter("HTTP_API_VERSION", "v1")
	HttpApiServiceName = Getter("HTTP_API_SERVICE_NAME", "admin")

	RequestTimeout, _       = strconv.Atoi(Getter("HTTP_TIMEOUT", "0"))           // in seconds
	HealthCheckFrequency, _ = strconv.Atoi(Getter("HEALTH_CHECK_FREQUENCY", "0")) // in seconds

	ConfigurationsServices = GetPluginServices("CONFIGURATIONS_SERVICES")
	FormServices           = GetPluginServices("FORM_SERVICES")
	MailTemplatesServices  = GetPluginServices("MAIL_TEMPLATES_SERVICES")
	MediaServices          = GetPluginServices("MEDIA_SERVICES")
	MenuServices           = GetPluginServices("MENU_SERVICES")
	ModelsServices         = GetPluginServices("MODELS_SERVICES")
	ModelsV2Services       = GetPluginServices("MODELS_V2_SERVICES")
	ReviewsServices        = GetPluginServices("REVIEWS_SERVICES")

	GinMode = Getter("GIN_MODE", gin.DebugMode)

	KeyCloakCert = Getter("KEYCLOAK_CERT", "")
	//UseAccessMiddleware, _ = strconv.ParseBool(Getter("USE_ACCESS_MIDDLEWARE", "true"))
)

// Getter -
func Getter(key, defaultValue string) string {
	env, ok := os.LookupEnv(key)
	if ok {
		return env
	}
	return defaultValue
}

func GetPluginServices(key string) []entity.Service {
	servicesKeys := Getter(key, "")
	if servicesKeys == "" {
		return []entity.Service{}
	}

	sk := strings.Split(servicesKeys, ";")
	services := make([]entity.Service, 0, len(sk))

	for _, serviceKey := range sk {
		serviceDesc := Getter(serviceKey, "")

		res := strings.Split(serviceDesc, ";")
		if len(res) < 3 {
			continue
		}

		endpoint, err := url.Parse(res[2])
		if err != nil {
			continue
		}
		var icon string
		if len(res) > 3 {
			icon = res[3]
		}
		services = append(services, entity.Service{Code: res[0], Name: res[1], Endpoint: *endpoint, Icon: icon})
	}

	return services
}
