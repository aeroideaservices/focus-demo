package services_definitions

import (
	"github.com/aeroideaservices/focus/mail-templates/plugin"
	"github.com/aeroideaservices/focus/mail-templates/postgres"
	"github.com/aeroideaservices/focus/mail-templates/rest"
	"github.com/aeroideaservices/focus/services/callbacks"
	"github.com/sarulabs/di/v2"
)

var MailTemplatesDefinitions = appendArr([]di.Def{
	{
		Name: "focus.mailTemplates.actions.mailTemplates.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("mailTemplates", "mailTemplates"), nil
		},
	},
}, plugin.Definitions, postgres.Definitions, rest.Definitions)
