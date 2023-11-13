# build stage
FROM golang:1.18.0-alpine as build

ARG ssh_key

RUN apk add alpine-sdk

RUN mkdir /app
WORKDIR /app
COPY ./ .

RUN go clean --modcache
RUN apk update && apk upgrade && apk add --no-cache ca-certificates
RUN update-ca-certificates
RUN apk add --no-cache openssh
RUN mkdir ~/.ssh
RUN chmod 700 ~/.ssh
RUN echo "$ssh_key" | base64 -d | tr -d '\r' > ~/.ssh/id_rsa && \
    chmod 600 ~/.ssh/id_rsa
RUN echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config
RUN git config --global url.ssh://git@gitlab.aeroidea.ru:15123/.insteadOf https://gitlab.aeroidea.ru/

RUN GOOS=linux GOARCH=amd64 go build -a -tags musl -a -installsuffix cgo -o main cmd/main.go
RUN GOOS=linux GOARCH=amd64 go build -a -tags musl -a -installsuffix cgo -o cli cmd/cli/worker.go

RUN mkdir /psql-certs
RUN wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O /psql-certs/psql.crt && chmod 0600 /psql-certs/psql.crt

FROM golang:alpine
COPY --from=build /app/main /
COPY --from=build /app/migrations /migrations
COPY --from=build /app/cli /
COPY --from=build /app/fixtures_data /fixtures_data
COPY --from=build /psql-certs /

WORKDIR /
EXPOSE 8080
ENTRYPOINT ["/main"]