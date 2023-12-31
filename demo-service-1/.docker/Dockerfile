# build stage
FROM golang:1.21.0-alpine as build

RUN apk add alpine-sdk

RUN mkdir /app
WORKDIR /app
COPY ./ .

RUN go clean --modcache
RUN apk update && apk upgrade && apk add --no-cache ca-certificates
RUN update-ca-certificates
RUN apk add --no-cache openssh
RUN GOOS=linux GOARCH=amd64 go build -a -tags musl -a -installsuffix cgo -o main cmd/main.go
RUN GOOS=linux GOARCH=amd64 go build -a -tags musl -a -installsuffix cgo -o cli cmd/cli/worker.go

FROM golang:alpine
COPY --from=build /app/main /
COPY --from=build /app/migrations /migrations
COPY --from=build /app/cli /
COPY --from=build /app/fixtures_data /fixtures_data

WORKDIR /
EXPOSE 8080
ENTRYPOINT ["/main"]