package translations

//go:generate gotext -srclang=en-GB update -out=catalog.go -lang=en-GB,ru-RU content/cmd
//go:generate gotext extract
//go:generate golangci-lint run
