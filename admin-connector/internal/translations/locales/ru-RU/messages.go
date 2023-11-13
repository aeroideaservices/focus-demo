package ru_RU

import (
	"admin-connector/internal/translations/locales"
	"golang.org/x/text/language"
	"golang.org/x/text/message/catalog"
)

var (
	Messages = locales.Messages{
		Language: language.Russian,
		Messages: []locales.Message{
			{
				Key: "forbidden",
				Msg: []catalog.Message{catalog.String("Доступ запрещен.")},
			},
			{
				Key: "auth required",
				Msg: []catalog.Message{catalog.String("Необходимо авторизоваться.")},
			},
			{
				Key: "unexpected signing method",
				Msg: []catalog.Message{catalog.String("Ошибка авторизации.")},
			},
			{
				Key: "authorization error",
				Msg: []catalog.Message{catalog.String("Ошибка авторизации.")},
			},
		},
	}
)
