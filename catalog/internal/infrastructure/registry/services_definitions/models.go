package services_definitions

import (
	demoEntity "catalog/internal/domain/entitiy"
	"catalog/internal/infrastructure/env"
	"context"
	"github.com/aeroideaservices/focus/media/plugin/actions"
	"github.com/aeroideaservices/focus/media/plugin/entity"
	models_s3 "github.com/aeroideaservices/focus/models/aws_s3"
	"github.com/aeroideaservices/focus/models/plugin"
	"github.com/aeroideaservices/focus/models/plugin/form"
	"github.com/aeroideaservices/focus/models/postgres"
	"github.com/aeroideaservices/focus/models/rest"
	"github.com/aeroideaservices/focus/models/xlsx"
	"github.com/google/uuid"
	"github.com/sarulabs/di/v2"
	"net/http"
)

var ModelsDefinitions = appendArr([]di.Def{
	{
		Name: "focus.models.registry.models",
		Build: func(ctn di.Container) (interface{}, error) {
			// регистрация кастомных полей формы
			if viewsExtrasInterface, err := ctn.SafeGet("focus.models.form.views.extra"); err == nil && viewsExtrasInterface != nil {
				viewsExtras := viewsExtrasInterface.(form.ViewsExtras)
				form.RegisterViewsExtras(viewsExtras)
			}

			return []any{
				&demoEntity.Brand{},
				&demoEntity.Model{},
				&demoEntity.Color{},
				&demoEntity.Rim{},
				&demoEntity.Equipment{},
				&demoEntity.Car{},
			}, nil
		},
	},
	{
		Name: "focus.models.fileStorage.baseEndpoint",
		Build: func(ctn di.Container) (interface{}, error) {
			return env.AwsEndpoint + "/" + env.AwsBucket, nil
		},
	},
	{
		Name: "focus.models.form.views.extra",
		Build: func(ctn di.Container) (interface{}, error) {
			mediaUploadURI := "/media/files/upload"
			if env.PluginsMediaFolderName != "" {
				folderId, err := getFolderIdOrCreateFolder(ctn, context.Background(), env.PluginsMediaFolderName)
				if err != nil {
					return nil, err
				}
				mediaUploadURI += "?folderId=" + folderId.String()
			}
			var pluginsMediaFolderId *uuid.UUID
			if env.PluginsMediaFolderName != "" {
				var err error
				pluginsMediaFolderId, err = getFolderIdOrCreateFolder(ctn, context.Background(), env.PluginsMediaFolderName)
				if err != nil {
					return nil, err
				}
			}
			return form.ViewsExtras{
				"pluginsMedia": form.ViewExtras{
					"folderId": pluginsMediaFolderId,
				},
				"brandSelect": form.ViewExtras{
					"identifier": "id",
					"display":    []string{"name"},
					"request": form.Request{
						URI:  "/models-v2/brands/elements/list",
						Meth: http.MethodPost,
						Body: map[string]any{
							"fields": []string{"name"},
						},
						Paginated: true,
					},
				},
				"modelSelect": form.ViewExtras{
					"identifier": "id",
					"display":    []string{"name"},
					"request": form.Request{
						URI:  "/models-v2/models/elements/list",
						Meth: http.MethodPost,
						Body: map[string]any{
							"fields": []string{"name"},
						},
						Paginated: true,
					},
				},
				"colorSelect": form.ViewExtras{
					"identifier": "id",
					"display":    []string{"name"},
					"request": form.Request{
						URI:  "/models-v2/colors/elements/list",
						Meth: http.MethodPost,
						Body: map[string]any{
							"fields": []string{"name"},
						},
						Paginated: true,
					},
				},
				"rimSelect": form.ViewExtras{
					"identifier": "id",
					"display":    []string{"name"},
					"request": form.Request{
						URI:  "/models-v2/rim/elements/list",
						Meth: http.MethodPost,
						Body: map[string]any{
							"fields": []string{"name"},
						},
						Paginated: true,
					},
				},
				"equipmentSelect": form.ViewExtras{
					"identifier": "id",
					"display":    []string{"name"},
					"request": form.Request{
						URI:  "/models-v2/equipments/elements/list",
						Meth: http.MethodPost,
						Body: map[string]any{
							"fields": []string{"name"},
						},
						Paginated: true,
					},
				},
				"sluggableOnName": form.ViewExtras{
					"dependsOn": map[string]any{"code": "name", "generate": "sluggable"},
				},
				"sluggableOnTitle": form.ViewExtras{
					"dependsOn": map[string]any{"code": "title", "generate": "sluggable"},
				},
			}, nil
		},
	},
}, plugin.Definitions, postgres.Definitions, rest.Definitions, xlsx.Definitions, models_s3.Definitions)

func appendArr[T any](defs ...[]T) []T {
	var res []T
	for _, def := range defs {
		res = append(res, def...)
	}

	return res
}

func getFolderIdOrCreateFolder(ctn di.Container, ctx context.Context, folderName string) (*uuid.UUID, error) {
	folderRepo := ctn.Get("focus.media.repository.folder").(actions.FolderRepository)

	var folderId uuid.UUID
	folders, err := folderRepo.List(ctx, actions.Filter{
		Name:         folderName,
		WithFolderId: true,
	})
	if err != nil {
		return nil, err
	}

	if len(folders) == 0 {
		folderId = uuid.New()
		err := folderRepo.Create(ctx, &entity.Folder{
			Id:   folderId,
			Name: folderName,
		})
		if err != nil {
			return nil, err
		}
	} else {
		folderId = folders[0].Id
	}

	return &folderId, nil
}
