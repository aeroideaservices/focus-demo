package env

import (
	"fmt"
	"os"
)

var (
	LogLevel = Getter("LOG_LEVEL", "debug")
	GinMode  = Getter("GIN_MODE", "debug")

	// ------------------------ HTTP ----------------------- //
	HTTPPort           = fmt.Sprintf(":%s", Getter("HTTP_PORT", "8080"))
	HTTPApiRoot        = Getter("HTTP_API_ROOT", "api")
	HTTPApiVersion     = Getter("HTTP_API_VERSION", "v1")
	HTTPApiServiceName = Getter("HTTP_API_SERVICE_NAME", "demo")
	HTTPApiFocusPath   = Getter("HTTP_API_VERSION", "admin")

	// ------------------------ DB ------------------------- //
	DbDriver      = Getter("DB_DRIVER", "postgres")
	DbHost        = Getter("DB_HOST", "")
	DbPort        = Getter("DB_PORT", "")
	DbUser        = Getter("DB_USER", "")
	DbName        = Getter("DB_NAME", "")
	DbPassword    = Getter("DB_PASSWORD", "")
	DbSslMode     = Getter("DB_SSL_MODE", "disable")
	DbSslCertPath = Getter("DB_SSL_CERT_PATH", "")

	// ------------------------ JAEGER ----------------------- //
	TraceHeader = Getter("TRACE_HEADER", "x-b3-traceid")

	// ------------------------ FOCUS ----------------------- //
	PluginsMediaFolderName = Getter("PLUGINS_MEDIA_FOLDER_NAME", ".plugins_media")

	// ----------------------- AWS S3 ---------------------- //
	AwsEndpoint        = Getter("AWS_ENDPOINT", "")
	AwsAccessKeyID     = Getter("AWS_ACCESS_KEY_ID", "")
	AwsSecretAccessKey = Getter("AWS_SECRET_ACCESS_KEY", "")
	AwsBucket          = Getter("AWS_BUCKET", "demo")
	AwsRegion          = Getter("AWS_REGION", "")
)

// Getter -
func Getter(key, defaultValue string) string {
	env, ok := os.LookupEnv(key)
	if ok {
		return env
	}
	return defaultValue
}
