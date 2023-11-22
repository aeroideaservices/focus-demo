package use_case

import "github.com/aeroideaservices/focus/services/access_control"

type Plugin struct {
	Code string `json:"code"`
	Name string `json:"name"`
}

type ServicePreview struct {
	Code    string   `json:"code"`
	Name    string   `json:"name"`
	Plugins []string `json:"plugins"`
	Icon    string   `json:"icon"`
}

type GetServiceDto struct {
	ServiceCode string               `json:"serviceCode" validate:"notBlank,sluggable"`
	Role        *access_control.Role `validate:""`
}

type GetServicesListDto struct {
	Role *access_control.Role `validate:""`
}
