package services_definitions

import (
	"net/url"

	"github.com/sarulabs/di/v2"

	s3 "github.com/aeroideaservices/focus/media/aws-s3"
	"github.com/aeroideaservices/focus/media/plugin"
	"github.com/aeroideaservices/focus/media/postgres"
	"github.com/aeroideaservices/focus/media/rest"
	"github.com/aeroideaservices/focus/services/callbacks"

	"users/internal/infrastructure/env"
)

var MediaDefinitions = appendArr([]di.Def{
	{
		Name: "focus.media.baseUrl",
		Build: func(ctn di.Container) (interface{}, error) {
			return url.Parse(env.AwsEndpoint + "/" + env.AwsBucket)
		},
	},
	{
		Name: "focus.media.actions.media.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("media", "media"), nil
		},
	},
	{
		Name: "focus.media.actions.folders.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return callbacksTest("media", "folders"), nil
		},
	},
}, plugin.Definitions, postgres.Definitions, s3.Definitions, rest.Definitions)
