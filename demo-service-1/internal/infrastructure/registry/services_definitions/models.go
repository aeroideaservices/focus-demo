package services_definitions

import (
	"context"
	demoEntity "demo/internal/domain/entitiy"
	"github.com/aeroideaservices/focus/media/plugin/actions"
	"github.com/aeroideaservices/focus/media/plugin/entity"
	models_s3 "github.com/aeroideaservices/focus/models/aws_s3"
	"github.com/aeroideaservices/focus/models/plugin"
	"github.com/aeroideaservices/focus/models/plugin/form"
	"github.com/aeroideaservices/focus/models/postgres"
	"github.com/aeroideaservices/focus/models/rest"
	"github.com/aeroideaservices/focus/models/xlsx"
	"github.com/aeroideaservices/focus/services/callbacks"
	"github.com/google/uuid"
	"github.com/sarulabs/di/v2"
	"net/http"

	"demo/internal/infrastructure/env"
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
				&demoEntity.Category{},
				&demoEntity.Product{},
				&demoEntity.Store{},
				&demoEntity.Promo{},
			}, nil
		},
	},
	{
		Name: "focus.models.actions.models.callbacks",
		Build: func(ctn di.Container) (interface{}, error) {
			callbacksTest := ctn.Get("focus.callbacks.test").(func(plugin, entity string) callbacks.Callbacks)

			return map[string]callbacks.Callbacks{
				"categories": callbacksTest("models", "categories"),
				"products":   callbacksTest("models", "products"),
				"stores":     callbacksTest("models", "stores"),
				"promos":     callbacksTest("models", "promos"),
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
			if env.EditorJSMediaFolderName != "" {
				folderId, err := getFolderIdOrCreateFolder(ctn, context.Background(), env.EditorJSMediaFolderName)
				if err != nil {
					return nil, err
				}
				mediaUploadURI += "?folderId=" + folderId.String()
			}
			var productMediaFolderId *uuid.UUID
			if env.ProductMediaFolderName != "" {
				var err error
				productMediaFolderId, err = getFolderIdOrCreateFolder(ctn, context.Background(), env.ProductMediaFolderName)
				if err != nil {
					return nil, err
				}
			}
			var storeMediaFolderId *uuid.UUID
			if env.StoreMediaFolderName != "" {
				var err error
				storeMediaFolderId, err = getFolderIdOrCreateFolder(ctn, context.Background(), env.StoreMediaFolderName)
				if err != nil {
					return nil, err
				}
			}
			var promoMediaFolderId *uuid.UUID
			if env.PromoMediaFolderName != "" {
				var err error
				promoMediaFolderId, err = getFolderIdOrCreateFolder(ctn, context.Background(), env.PromoMediaFolderName)
				if err != nil {
					return nil, err
				}
			}
			return form.ViewsExtras{
				"storeEditorJs": form.ViewExtras{
					"mediaUpload": map[string]string{
						"byFile": mediaUploadURI,
					},
					"productsHints": map[string]any{
						"identifier": "id",
						"display":    []string{"externalId", "name"},
						"request": form.Request{
							URI:  "/models-v2/product/elements/list",
							Meth: http.MethodPost,
							Body: map[string]any{
								"fields": []string{"externalId", "name"},
							},
							Paginated: true,
						},
					},
				},
				"promoEditorJs": form.ViewExtras{
					"mediaUpload": map[string]string{
						"byFile": mediaUploadURI,
					},
					"productsHints": map[string]any{
						"identifier": "id",
						"display":    []string{"externalId", "name"},
						"request": form.Request{
							URI:  "/models-v2/product/elements/list",
							Meth: http.MethodPost,
							Body: map[string]any{
								"fields": []string{"externalId", "name"},
							},
							Paginated: true,
						},
					},
				},
				"categorySelect": form.ViewExtras{
					"identifier": "id",
					"display":    []string{"name"},
					"request": form.Request{
						URI:  "/models-v2/categories/elements/list",
						Meth: http.MethodPost,
						Body: map[string]any{
							"fields": []string{"name"},
						},
						Paginated: true,
					},
				},
				"selectProducts": form.ViewExtras{
					"identifier": "id",
					"display":    []string{"externalId", "name"},
					"request": form.Request{
						URI:  "/models-v2/products/elements/list",
						Meth: http.MethodPost,
						Body: map[string]any{
							"fields": []string{"externalId", "name"},
						},
						Paginated: true,
					},
				},
				"productGallery": form.ViewExtras{
					"folderId": productMediaFolderId,
				},
				"storesMedia": form.ViewExtras{
					"folderId": storeMediaFolderId,
				},
				"promosMedia": form.ViewExtras{
					"folderId": promoMediaFolderId,
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
