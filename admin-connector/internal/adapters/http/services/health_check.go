package services

import (
	"admin-connector/internal/domain/entity"
	"admin-connector/internal/infrastructure/env"
	"context"
	"github.com/aeroideaservices/focus/services/errors"
	"go.uber.org/zap"
	"io"
	"net/http"
	"time"
)

type ServicesAvailability map[string]bool

type ServicesChecker struct {
	services             []entity.Service
	servicesAvailability ServicesAvailability
	logger               *zap.SugaredLogger
}

func NewServicesChecker(
	services []entity.Service,
	logger *zap.SugaredLogger,
) *ServicesChecker {
	return &ServicesChecker{
		services:             services,
		servicesAvailability: ServicesAvailability{},
		logger:               logger,
	}
}

func (s *ServicesChecker) CheckServiceAvailability(serviceCode string) error {
	if serviceCode == "" {
		return errors.BadRequest.Newf("service code is required")
	}

	if availability, ok := s.servicesAvailability[serviceCode]; ok {
		if availability {
			return nil
		}
		return errors.ServiceUnavailable.Newf("service %s is unavailable now", serviceCode)
	}

	return errors.NotFound.Newf("service %s is not registered", serviceCode)
}

func (s *ServicesChecker) CheckAll() {
	frequency := time.Second * time.Duration(env.HealthCheckFrequency)
	if frequency == 0 {
		frequency = time.Second * 60
	}
	go func() {
		for {
			for _, service := range s.services {
				ctx, cancel := context.WithTimeout(context.Background(), time.Minute*3)
				s.servicesAvailability[service.Code] = s.checkService(ctx, service)
				cancel()
			}
			time.Sleep(frequency)
		}
	}()
}

func (s *ServicesChecker) checkService(ctx context.Context, service entity.Service) bool {
	request, err := http.NewRequestWithContext(ctx, http.MethodGet, service.Endpoint.String()+"/health/check", nil)
	if err != nil {
		panic(err)
	}

	response, err := http.DefaultClient.Do(request)
	if err != nil {
		s.logger.Errorw("error while sending health check request to "+service.Code, "err", err)
		return false
	}

	defer func(Body io.ReadCloser) { _ = Body.Close() }(response.Body)
	if response.StatusCode != http.StatusOK {
		s.logger.Warnw("got bad health check status code from "+service.Code, "statusCode", response.StatusCode)
		return false
	}

	return true
}
