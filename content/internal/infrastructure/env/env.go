package env

import (
	"fmt"
	"os"
	"strconv"
)

var (
	LogLevel = Getter("LOG_LEVEL", "debug")
	GinMode  = Getter("GIN_MODE", "debug")

	// ------------------------ HTTP ----------------------- //
	HTTPPort           = fmt.Sprintf(":%s", Getter("HTTP_PORT", "8188"))
	HTTPApiRoot        = Getter("HTTP_API_ROOT", "api")
	HTTPApiVersion     = Getter("HTTP_API_VERSION", "v1")
	HTTPApiServiceName = Getter("HTTP_API_SERVICE_NAME", "content")
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

	// ----------------------- AWS S3 ---------------------- //
	AwsEndpoint        = Getter("AWS_ENDPOINT", "")
	AwsAccessKeyID     = Getter("AWS_ACCESS_KEY_ID", "")
	AwsSecretAccessKey = Getter("AWS_SECRET_ACCESS_KEY", "")
	AwsBucket          = Getter("AWS_BUCKET", "content")
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

// GetterInt -
func GetterInt(key string, defaultValue int) int {
	env, ok := os.LookupEnv(key)
	if !ok {
		return defaultValue
	}
	intEnv, err := strconv.Atoi(env)
	if err != nil {
		return defaultValue
	}

	return intEnv
}

// GetterBool -
func GetterBool(key string, defaultValue bool) bool {
	env, ok := os.LookupEnv(key)
	if ok {
		res, err := strconv.ParseBool(env)
		if err == nil {
			return res
		}
	}
	return defaultValue
}
