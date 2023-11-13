package en_GB

import (
	"admin-connector/internal/translations/locales"
	"golang.org/x/text/language"
	"golang.org/x/text/message/catalog"
)

var (
	Messages = locales.Messages{
		Language: language.English,
		Messages: []locales.Message{
			{
				Key: "forbidden",
				Msg: []catalog.Message{catalog.String("Forbidden.")},
			},
			{
				Key: "auth required",
				Msg: []catalog.Message{catalog.String("Authorization required.")},
			},
			{
				Key: "unexpected signing method",
				Msg: []catalog.Message{catalog.String("Authorization error.")},
			},
			{
				Key: "authorization error",
				Msg: []catalog.Message{catalog.String("Authorization error.")},
			},
		},
	}
)
