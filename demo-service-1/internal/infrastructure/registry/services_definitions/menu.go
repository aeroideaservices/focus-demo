package services_definitions

import (
	"github.com/aeroideaservices/focus/menu/plugin"
	"github.com/aeroideaservices/focus/menu/postgres"
	"github.com/aeroideaservices/focus/menu/rest"
	"github.com/aeroideaservices/focus/services/callbacks"
	"github.com/sarulabs/di/v2"
)

var MenuDefinitions = appendArr([]di.Def{
	{
		Name: "focus.menu.maxMenuItemsDepth",
		Build: func(ctn di.Container) (interface{}, error) {
			return 10, nil
		},
	},
	{
		Name: "focus.menu.actions.menus.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("menu", "menus"), nil
		},
	},
	{
		Name: "focus.menu.actions.menuItems.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("menu", "menuItems"), nil
		},
	},
}, plugin.Definitions, postgres.Definitions, rest.Definitions)
