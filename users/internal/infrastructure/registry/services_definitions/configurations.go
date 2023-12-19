package services_definitions

import (
	"demo/internal/adapters/rest/handlers"
	"github.com/aeroideaservices/focus/services/callbacks"
	"github.com/sarulabs/di/v2"

	"github.com/aeroideaservices/focus/configurations/plugin"
	"github.com/aeroideaservices/focus/configurations/plugin/actions"
	"github.com/aeroideaservices/focus/configurations/postgres"
	"github.com/aeroideaservices/focus/configurations/rest"
	"github.com/aeroideaservices/focus/services/validation"
)

var ConfigurationsDefinitions = appendArr([]di.Def{
	{
		Name: "optionsHandler",
		Build: func(ctn di.Container) (interface{}, error) {
			options := ctn.Get("focus.configurations.actions.options").(*actions.Options)
			validator := ctn.Get("focus.validator").(*validation.Validator)
			return handlers.NewOptionsHandler(options, validator), nil
		},
	},
	{
		Name: "focus.configurations.actions.configurations.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("configurations", "configurations"), nil
		},
	},
	{
		Name: "focus.configurations.actions.options.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("configurations", "options"), nil
		},
	},
}, plugin.Definitions, postgres.Definitions, rest.Definitions)
