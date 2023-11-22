package use_case

import (
	services_checker "admin-connector/internal/adapters/http/services"
	"admin-connector/internal/domain/entity"
	"context"
	"github.com/aeroideaservices/focus/services/access_control"
	"github.com/aeroideaservices/focus/services/errors"
	"golang.org/x/exp/maps"
	"golang.org/x/exp/slices"
	"net/http"
)

type ServiceUseCase struct {
	pluginsServices map[string][]entity.Service
	services        []entity.Service
	servicesChecker *services_checker.ServicesChecker
}

func NewServiceUseCase(
	pluginsServices map[string][]entity.Service,
	services []entity.Service,
	servicesChecker *services_checker.ServicesChecker,
) *ServiceUseCase {
	return &ServiceUseCase{
		pluginsServices: pluginsServices,
		services:        services,
		servicesChecker: servicesChecker,
	}
}

func (uc ServiceUseCase) GetList(_ context.Context, dto GetServicesListDto) []*ServicePreview {
	serviceMap := make(map[string]*ServicePreview)
	for plugin, services := range uc.pluginsServices {
		for _, service := range services {
			if !hasAccess(dto.Role, service.Code, plugin) {
				continue
			}
			if _, ok := serviceMap[service.Code]; !ok {
				serviceMap[service.Code] = &ServicePreview{Code: service.Code, Name: service.Name}
			}
			plugins := append(serviceMap[service.Code].Plugins, plugin)
			serviceMap[service.Code].Plugins = plugins
			serviceMap[service.Code].Icon = service.Icon
		}
	}

	res := make([]*ServicePreview, 0, len(serviceMap))
	for _, service := range maps.Values(serviceMap) {
		if err := uc.servicesChecker.CheckServiceAvailability(service.Code); err != nil {
			continue
		}
		slices.Sort(service.Plugins)
		res = append(res, service)
	}
	slices.SortFunc(res, func(a *ServicePreview, b *ServicePreview) bool {
		return a.Name < b.Name
	})

	return res
}

func (uc ServiceUseCase) Get(_ context.Context, dto GetServiceDto) (*ServicePreview, error) {
	var service *ServicePreview
	for plugin, services := range uc.pluginsServices {
		if idx := slices.IndexFunc(services, func(service entity.Service) bool { return service.Code == dto.ServiceCode }); idx != -1 {
			if service == nil {
				service = &ServicePreview{Code: services[idx].Code, Name: services[idx].Name, Icon: services[idx].Icon}
			}
			if !hasAccess(dto.Role, service.Code, plugin) {
				continue
			}
			service.Plugins = append(service.Plugins, plugin)
		}
	}

	if service == nil {
		return nil, errors.NotFound.Newf("service '%s' not found", dto.ServiceCode)
	}
	if err := uc.servicesChecker.CheckServiceAvailability(dto.ServiceCode); err != nil {
		return nil, err
	}

	slices.Sort(service.Plugins)

	return service, nil
}

func (uc ServiceUseCase) GetEndpoint(_ context.Context, dto GetServiceDto) (*entity.Service, error) {
	var service *entity.Service
	idx := slices.IndexFunc(uc.services, func(service entity.Service) bool {
		return service.Code == dto.ServiceCode
	})
	if idx == -1 {
		return nil, errors.NotFound.Newf("service '%s' not found", dto.ServiceCode)
	}

	service = &uc.services[idx]
	if err := uc.servicesChecker.CheckServiceAvailability(dto.ServiceCode); err != nil {
		return nil, err
	}

	return service, nil
}

func hasAccess(role *access_control.Role, service, plugin string) bool {
	if role == nil {
		return true
	}

	action := access_control.NewAction(service+"."+plugin, http.MethodGet)
	return role.HasAccess(action)
}
