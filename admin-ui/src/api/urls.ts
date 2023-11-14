export const URLS = {
  configuration: {
    getConfigurations: '/configurations',
    addConfigurations: '/configurations',
    getConfigurationsById: (id: string) => `/configurations/${id}`,
    putConfigurationsById: (id: string) => `/configurations/${id}`,
    delConfigurationsById: (id: string) => `/configurations/${id}`,
    getConfigurationsOptionsById: (id: string) => `/configurations/${id}/options`,
    addConfigurationsOptionsById: (id: string) => `/configurations/${id}/options`,
    putConfigurationsOptionsById: (id: string) => `/configurations/${id}/options`,
    getConfigurationOptionById: (confId: string, optId: string) =>
      `/configurations/${confId}/options/${optId}`,
    putConfigurationOptionById: (confId: string, optId: string) =>
      `/configurations/${confId}/options/${optId}`,
    delConfigurationOptionById: (confId: string, optId: string) =>
      `/configurations/${confId}/options/${optId}`,
  },
  mailsTemplate: {
    getMailsTemplates: '/mail-templates',
    delMailsTemplateById: (id: string) => `/mail-templates/${id}`,
    getMailTemplate: (id: string) => `/mail-templates/${id}`,
    putMailTemplate: (id: string) => `/mail-templates/${id}`,
  },
  media: {
    getMedia: '/media',
    getFolders: '/media/folders',
    addFolder: '/media/folders',
    getFolderInfo: (id: string) => `/media/folders/${id}`,
    delFolder: (id: string) => `/media/folders/${id}`,
    moveFolder: (id: string) => `/media/folders/${id}/move`,
    renameFolder: (id: string) => `/media/folders/${id}/rename`,
    addFile: '/media/files',
    addFiles: 'media/files/upload-list',
    uploadFile: 'media/files/upload',
    getFileInfo: (id: string) => `/media/files/${id}`,
    delFile: (id: string) => `/media/files/${id}`,
    moveFile: (id: string) => `/media/files/${id}/move`,
    renameFile: (id: string) => `/media/files/${id}/rename`,
  },
  models: {
    getModels: '/models',
    getModel: (id: string) => `/models/${id}`,
    getModelSettings: (id: string) => `models/${id}/settings`,
    getModelFields: (id: string) => `models/${id}/fields`,
    getModelField: (modelId: string, fieldId: string) => `models/${modelId}/fields/${fieldId}`,
    getModelFieldValues: (modelId: string, fieldId: string) =>
      `models/${modelId}/fields/${fieldId}/values`,
    getModelElementsList: (id: string) => `models/${id}/elements/list`,
    getModelElements: (id: string) => `models/${id}/elements`,
    addModelElement: (id: string) => `models/${id}/elements`,
    delModelElements: (id: string) => `models/${id}/elements/batch-delete`,
    getModelElement: (modelId: string, elementId: string) =>
      `models/${modelId}/elements/${elementId}`,
    changeModelElement: (modelId: string, elementId: string) =>
      `models/${modelId}/elements/${elementId}`,
    delModelElement: (modelId: string, elementId: string) =>
      `models/${modelId}/elements/${elementId}`,
    postExportModel: (modelId: string) => `models/${modelId}/export`,
    getExportModel: (modelId: string) => `models/${modelId}/export`,
    getDefaultKladr: 'address-list',
  },
  models_v2: {
    models: {
      getModels: '/models-v2', // Получение списка моделей
      getModel: (modelCode: string) => `/models-v2/${modelCode}`, // Получение описания модели
    },
    modelFieldValues: {
      getModelFieldValues: (modelCode: string, fieldCode: string) =>
        `/models-v2/${modelCode}/fields/${fieldCode}`, // Получение значений для параметра фильтрации. Тип (список)
    },
    modelElements: {
      addModelElements: (modelCode: string) => `/models-v2/${modelCode}/elements`, // Создание элемента модели
      getModelElementsList: (modelCode: string) => `/models-v2/${modelCode}/elements/list`, // Получение списка элементов модели
      delModelElements: (modelCode: string) => `/models-v2/${modelCode}/elements/batch-delete`, // Массовое удаление элементов модели
    },
    modelElement: {
      getModelElement: (modelCode: string, modelElementId: string) =>
        `/models-v2/${modelCode}/elements/${modelElementId}`, // Получение элемента модели
      putModelElement: (modelCode: string, modelElementId: string) =>
        `/models-v2/${modelCode}/elements/${modelElementId}`, // Изменение элемента модели
      delModelElement: (modelCode: string, modelElementId: string) =>
        `/models-v2/${modelCode}/elements/${modelElementId}`, // Удаление элемента модели
    },
    modelExport: {
      getModelExport: (modelCode: string) => `/models-v2/${modelCode}/export`, // Получение информации о последнем экспорте модели
      postModelExport: (modelCode: string) => `/models-v2/${modelCode}/export`, // Инициация экспорта модели
    },
  },
  menus: {
    getMenu: `/menus`,
    addMenus: '/menus',
    getMenusById: (id: string) => `/menus/${id}`,
    putMenusById: (id: string) => `/menus/${id}`,
    delMenuById: (id: string) => `/menus/${id}`,
    getMenuItemsById: (id: string) => `/menus/${id}/items`,
    addMenuItemsById: (id: string) => `/menus/${id}/items`,
    getMenuItemById: (menuId: string, menuItemId: string) => `/menus/${menuId}/items/${menuItemId}`,
    putMenuItemById: (menuId: string, menuItemId: string) => `/menus/${menuId}/items/${menuItemId}`,
    delMenuItemById: (menuId: string, menuItemId: string) => `/menus/${menuId}/items/${menuItemId}`,
    moveMenuItem: (menuId: string, menuItemId: string) =>
      `/menus/${menuId}/items/${menuItemId}/move`,
    getDomains: '/menus/domains',
    addDomain: '/menus/domains',
  },
  admin: {
    service: '/services',
  },
  auth: {
    postAuth: (realm: string) => `/auth/realms/${realm}/protocol/openid-connect/token`,
    postAuthByRefresh: (realm: string) => `/auth/realms/${realm}/protocol/openid-connect/token`,
  },
  reviews: {
    addReview: '/reviews',
    reviewsList: `/reviews/list`,
    getReviewsById: (id: string) => `/reviews/${id}`,
    getEditReviewItemById: (id: string) => `/reviews/${id}`,
  },
};
