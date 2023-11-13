package services_definitions

import (
	"github.com/aeroideaservices/focus/forms/plugin"
	"github.com/aeroideaservices/focus/forms/postgres"
	"github.com/aeroideaservices/focus/forms/rest"
	"github.com/aeroideaservices/focus/services/callbacks"
	"github.com/sarulabs/di/v2"
)

var FormsDefinitions = appendArr([]di.Def{
	{
		Name: "focus.forms.actions.forms.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("forms", "forms"), nil
		},
	},
	{
		Name: "focus.forms.actions.formFields.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("forms", "formFields"), nil
		},
	},
	{
		Name: "focus.forms.actions.formResults.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("forms", "formResults"), nil
		},
	},
}, plugin.Definitions, postgres.Definitions, rest.Definitions)
