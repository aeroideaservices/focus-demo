package locales

import (
	"golang.org/x/text/language"
	"golang.org/x/text/message/catalog"
)

type Message struct {
	Key string
	Msg []catalog.Message
}

type Messages struct {
	Language language.Tag
	Messages []Message
}
