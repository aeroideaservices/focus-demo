package entity

import "net/url"

type Service struct {
	Code     string  `json:"code"`
	Name     string  `json:"name"`
	Endpoint url.URL `json:"endpoint"`
}
