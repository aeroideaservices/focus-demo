package translations

import (
	"admin-connector/internal/translations/locales"
	en_GB "admin-connector/internal/translations/locales/en-GB"
	ru_RU "admin-connector/internal/translations/locales/ru-RU"
	"golang.org/x/text/message"
)

var (
	translations = []locales.Messages{
		ru_RU.Messages,
		en_GB.Messages,
	}
)

func init() {
	var err error
	for _, translation := range translations {
		lan := translation.Language
		for _, msg := range translation.Messages {
			err = message.Set(lan, msg.Key, msg.Msg...)
			if err != nil {
				panic(err)
			}
		}
	}
}
