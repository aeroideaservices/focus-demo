import { FilterViewTypeEnum, TCodeAndHeaders, TModel, TModelElement, TModelExport } from '@/types';

import { createAsyncThunk, createSlice, PayloadAction } from '@reduxjs/toolkit';
import { isEmpty } from 'lodash';

import {
  apiAddModelElement,
  apiChangeModelElement,
  apiDelModelElement,
  apiDelModelElements,
  apiExportModel,
  apiGetDefaultKladr,
  apiGetExportModel,
  apiGetModel,
  apiGetModelElement,
  apiGetModelElementFields,
  apiGetModelElementFieldValues,
  apiGetModelElements,
  apiGetModelSettings,
  apiModelFieldValues,
} from '@/api';

import { createAxiosThunk, createThunkRequest } from '@/utils/asyncRequest';
import { getCookie } from '@/utils/cookie';
import notify from '@/utils/notify';

import { FilterTypes, TFilter } from '@/ui/organisms/FiltersBuilder/types';
import { downloadModalExport } from '@/ui/pages/ModelContainer/utils/downloadModalExport';

import api from '../../../api/instance';

interface IModelState {
  status: {
    fetchingGetModel: boolean;
    fetchingGetModelSettings: boolean;
    fetchingGetModelElements: boolean;
    fetchingDelModelElement: boolean;
    feachingDelModelElements: boolean;
    fetchingGetModelElementFields: boolean;
    fetchingAddModelElement: boolean;
    fetchingModelElement: boolean;
    fetchingGetExportModel: boolean;
  };
  modals: {
    delModelElementModal: boolean;
    newModelElementModal: boolean;
    editModelElementModal: boolean;
  };
  model: TModel | null;
  modelSettings: {
    filterable: TFilter[] | null;
    shownInList: TModel[] | null;
    sortable: TModel[] | null;
  };
  modelElements: TModelElement[] | null;
  modelElementsTotal: number;
  currentModelElement: Record<string, string> | null;
  selectedModelElements: Record<string, string>[] | null;
  modelElementFields: TModel[] | null;
  modelElementValues: TModelElement | null;
  filters: any;
  filtersToSend: any;
  mediaId?: string;
  currentIndex: number | null;
  searchData: any;
  chosenData: any;
  modelExport: TModelExport | null;
}

const initialState: IModelState = {
  status: {
    fetchingGetModel: false,
    fetchingGetModelSettings: false,
    fetchingGetModelElements: false,
    fetchingDelModelElement: false,
    feachingDelModelElements: false,
    fetchingGetModelElementFields: false,
    fetchingAddModelElement: false,
    fetchingModelElement: false,
    fetchingGetExportModel: false,
  },
  modals: {
    delModelElementModal: false,
    newModelElementModal: false,
    editModelElementModal: false,
  },
  model: null,
  modelSettings: {
    filterable: null,
    shownInList: null,
    sortable: null,
  },
  modelElements: null,
  modelElementsTotal: 0,
  currentModelElement: null,
  selectedModelElements: [],
  modelElementFields: null,
  modelElementValues: null,
  filters: {},
  filtersToSend: {},
  mediaId: undefined,
  currentIndex: null,
  searchData: [],
  chosenData: {},
  modelExport: null,
};

export const fetchGetModelAction = createAxiosThunk('getModels', apiGetModel);

export const fetchGetModelSettingsAction = createAsyncThunk(
  'getModelSettings',
  async (data: TCodeAndHeaders, { rejectWithValue }) => {
    const result = await apiGetModelSettings(data);
    if (!result) return rejectWithValue(null);
    const filterable: TFilter[] = await Promise.all(
      result.data.filterable.map(async (item) => {
        switch (item.viewType) {
          case FilterViewTypeEnum.STRING:
            const selectData = await apiGetModelElementFieldValues({
              modelCode: data.code,
              fieldCode: item.code,
            });
            return {
              ...item,
              viewType: FilterViewTypeEnum.MULTISELECT,
              data: selectData?.data.items || [],
              showOptionAll: true,
              inputProps: {
                searchable: true,
              },
            } as FilterTypes.IFilterMultiSelect;
          case FilterViewTypeEnum.DATE:
            return {
              ...item,
              viewType: FilterViewTypeEnum.DATE_RANGE,
            } as FilterTypes.IFilterDateRange;
          default:
            return item as TFilter;
        }
      })
    );

    return { ...result.data, filterable };
  }
);

export const fetchGetModelElementsAction = createAxiosThunk(
  'getModelElements',
  apiGetModelElements
);
export const fetchDelModelElementAction = createAxiosThunk(
  'deleteModelElement',
  apiDelModelElement
);
export const fetchDelModelElementsAction = createAxiosThunk(
  'deleteModelElements',
  apiDelModelElements
);
export const fetchModelElementFieldsAction = createAxiosThunk(
  'getModelElementFields',
  apiGetModelElementFields
);
export const fetchAddModelElementAction = createAxiosThunk('addModelElement', apiAddModelElement);
export const fetchGetModelElementAction = createAxiosThunk('getModelElement', apiGetModelElement);
export const fetchGetModelElementPreviewAction = createAxiosThunk(
  'getModelPreviewElement',
  apiGetModelElement
);
export const fetchChangeModelElementAction = createAxiosThunk(
  'changeModelElement',
  apiChangeModelElement
);

export const fetchModelFieldValues = createThunkRequest(
  'modelFieldValues',
  apiModelFieldValues,
  ({ data }, params) => ({
    [params.elementId]: {
      ...data,
      items: data.items.map((item: any) => ({ value: item, label: item })),
    },
  })
);

export const fetchModelSearch = createAsyncThunk(
  'modelSearch',
  async (data: any, { rejectWithValue }) => {
    const url = data.uri.includes('http') ? data.uri : data.uri.replace('/api/v1/admin', '');
    const result =
      data.meth == 'POST'
        ? await api.post(url, { ...data.body, query: data.value })
        : await api.get(url, {
            params: data.isDefault
              ? { ...data.body, limit: 10, offset: 0, pkeys: data.value }
              : { ...data.body, query: data.value, limit: 10, offset: 0 },
          });

    if (result) {
      return { data: result, index: data.index, type: data.type, isDefault: data.isDefault };
    } else {
      return rejectWithValue(null);
    }
  }
);

export const fetchExportModel = createAxiosThunk('modelExport', apiExportModel);
export const fetchGetExportModel = createAxiosThunk('modelExport', apiGetExportModel);
export const fetchDefaultKladr = createAxiosThunk('defaultProducts', apiGetDefaultKladr);

export const modelSlice = createSlice({
  name: 'model',
  initialState,
  reducers: {
    setCurrentModelElement: (state, action: PayloadAction<Record<string, string> | null>) => {
      state.currentModelElement = action.payload;
    },
    setSelectedModelElements: (state, action: PayloadAction<Record<string, string>[] | null>) => {
      state.selectedModelElements = action.payload;
    },
    setOpenDelModelElementModal: (state, action: PayloadAction<boolean>) => {
      state.modals.delModelElementModal = action.payload;
    },
    setOpenNewModelElementModal: (state, action: PayloadAction<boolean>) => {
      state.modals.newModelElementModal = action.payload;
    },
    setOpenEditModelElementModal: (state, action: PayloadAction<boolean>) => {
      state.modals.editModelElementModal = action.payload;
    },
    setFiltersToSend: (state, action) => {
      if (Object.keys(action.payload).length) {
        state.filtersToSend = action.payload;
      } else state.filtersToSend = {};
    },
    setFilters: (state, action) => {
      state.filters = action.payload;
    },
    setMediaId: (state, action) => {
      state.mediaId = action.payload;
    },
    setCurrentIndex: (state, action) => {
      state.currentIndex = action.payload;
    },
    setModelSettingsFilterable: (state, action) => {
      state.modelSettings.filterable = action.payload;
    },
    setModelElements: (state, action) => {
      state.modelElements = action.payload;
    },
    setSearchData: (state, action) => {
      state.searchData = action.payload;
    },
    setChosenData: (state, action) => {
      if (isEmpty(action.payload)) {
        state.chosenData = action.payload;
      } else {
        const chosenValues = action.payload?.value?.map((item: any) => ({
          label: item.split('!')[1],
          value: `${item.split('!')[0]}!${item.split('!')[1]}`,
        }));

        if (chosenValues?.length <= 50 || action.payload.type === 'kladr') {
          state.chosenData = {
            ...state.chosenData,
            [action.payload?.index]: chosenValues,
          };
        } else {
          notify({ message: 'К акции можно добавить не более 50 товаров', type: 'error' });
        }
      }
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchChangeModelElementAction.fulfilled, (state) => {
        state.modals.editModelElementModal = false;
        notify({ message: 'Элемент модели изменен', type: 'success' });
      })
      .addCase(fetchChangeModelElementAction.rejected, (state) => {
        state.modals.editModelElementModal = false;
      });
    builder
      .addCase(fetchGetModelAction.pending, (state) => {
        state.status.fetchingGetModel = true;
      })
      .addCase(fetchGetModelAction.fulfilled, (state, action) => {
        state.status.fetchingGetModel = false;
        state.model = action.payload;
      })
      .addCase(fetchGetModelAction.rejected, (state) => {
        state.status.fetchingGetModel = false;
      });
    builder
      .addCase(fetchGetModelSettingsAction.pending, (state) => {
        state.status.fetchingGetModelSettings = true;
      })
      .addCase(fetchGetModelSettingsAction.fulfilled, (state, action) => {
        state.status.fetchingGetModelSettings = false;
        state.modelSettings.filterable = action.payload
          .filterable as typeof state.modelSettings.filterable; // To-do: refactor types
        state.modelSettings.shownInList = action.payload.shownInList;
        state.modelSettings.sortable = action.payload.sortable;
      })
      .addCase(fetchGetModelSettingsAction.rejected, (state) => {
        state.status.fetchingGetModelSettings = false;
      });
    builder
      .addCase(fetchGetModelElementsAction.pending, (state) => {
        state.status.fetchingGetModelElements = true;
      })
      .addCase(fetchGetModelElementsAction.fulfilled, (state, action) => {
        state.status.fetchingGetModelElements = false;
        state.modelElements = action.payload.items;
        state.modelElementsTotal = action.payload.total;
      })
      .addCase(fetchGetModelElementsAction.rejected, (state) => {
        state.status.fetchingGetModelElements = false;
      });
    builder
      .addCase(fetchDelModelElementAction.pending, (state) => {
        state.status.fetchingDelModelElement = true;
      })
      .addCase(fetchDelModelElementAction.fulfilled, (state, action) => {
        state.status.fetchingDelModelElement = false;
        state.modals.delModelElementModal = false;

        if (state?.selectedModelElements?.includes(action.payload.id))
          state!.selectedModelElements = state?.selectedModelElements.filter(
            (item) => item !== action.payload.id
          );

        notify({ message: 'Элемент модели удалён', type: 'success' });
      })
      .addCase(fetchDelModelElementAction.rejected, (state) => {
        state.status.fetchingDelModelElement = false;
      });
    builder
      .addCase(fetchDelModelElementsAction.pending, (state) => {
        state.status.feachingDelModelElements = true;
      })
      .addCase(fetchDelModelElementsAction.fulfilled, (state) => {
        state.status.feachingDelModelElements = false;
        state.selectedModelElements = null;
        state.modals.delModelElementModal = false;

        notify({ message: 'Элементы модели удалёны', type: 'success' });
      })
      .addCase(fetchDelModelElementsAction.rejected, (state) => {
        state.modals.delModelElementModal = false;
        state.status.feachingDelModelElements = false;
      });
    builder
      .addCase(fetchModelElementFieldsAction.pending, (state) => {
        state.modelElementFields = null;
        state.status.fetchingGetModelElementFields = true;
      })
      .addCase(fetchModelElementFieldsAction.fulfilled, (state, action) => {
        state.status.fetchingGetModelElementFields = false;
        state.modelElementFields = action.payload;
      })
      .addCase(fetchModelElementFieldsAction.rejected, (state) => {
        state.status.fetchingGetModelElementFields = false;
      });
    builder
      .addCase(fetchAddModelElementAction.pending, (state) => {
        state.status.fetchingAddModelElement = true;
      })
      .addCase(fetchAddModelElementAction.fulfilled, (state) => {
        state.status.fetchingAddModelElement = false;
        state.modals.newModelElementModal = false;

        notify({ message: 'Элемент добавлен', type: 'success' });
      })
      .addCase(fetchAddModelElementAction.rejected, (state) => {
        state.status.fetchingAddModelElement = false;
      });
    builder
      .addCase(fetchGetModelElementAction.pending, (state) => {
        state.status.fetchingModelElement = true;
      })
      .addCase(fetchGetModelElementAction.fulfilled, (state, action) => {
        state.status.fetchingModelElement = false;
        state.modelElementValues = action.payload;
      })
      .addCase(fetchGetModelElementAction.rejected, (state) => {
        state.status.fetchingModelElement = false;
      });
    builder
      .addCase(fetchGetModelElementPreviewAction.pending, (state) => {
        state.status.fetchingModelElement = true;
      })
      .addCase(fetchGetModelElementPreviewAction.fulfilled, (state, action) => {
        state.status.fetchingModelElement = false;

        const openLinkInNewTab = (url: string) => {
          const page = window.open(url, '_blank');

          if (page) page.focus();
        };

        const parsedToken = getCookie('token') as string;
        const token = parsedToken ? JSON.parse(parsedToken).access_token : null;
        const domain = process.env.PREVIEW_URL;
        const modelCode =
          window.location.pathname.split('/')[window.location.pathname.split('/').length - 1];
        const modelElementCode = action.payload.fieldValues.filter(
          (item) => item.code === 'code'
        )[0].value;

        if (modelCode === 'promo') {
          const promoURL = `${domain}/${modelCode}/${modelElementCode}?token=${token}`;
          const promoFullURL = `${domain}/${modelCode}/${modelElementCode}/full-condition/?token=${token}`;

          openLinkInNewTab(promoURL);

          setTimeout(() => {
            openLinkInNewTab(promoFullURL);
          }, 500);
        }

        if (modelCode === 'content-pages') {
          const contentLink = `${domain}/services/${modelElementCode}/?token=${token}`;

          openLinkInNewTab(contentLink);
        }

        if (modelCode === 'ref-brend') {
          const brandLink = `${domain}/brand/${modelElementCode}/?token=${token}`;

          openLinkInNewTab(brandLink);
        }
      })
      .addCase(fetchGetModelElementPreviewAction.rejected, (state) => {
        state.status.fetchingModelElement = false;
      });
    builder.addCase(fetchModelFieldValues.fulfilled, (state, action) => {
      state.filters = { ...state.filters, ...action.payload };
    });
    builder.addCase(fetchModelSearch.fulfilled, (state, action) => {
      if (action.payload.type === 'kladr') {
        const searched = action.payload?.data?.data
          ? action.payload?.data?.data?.map((item: any) => ({
              label: item.value,
              value: `${item.kladrId}!${item.value}`,
            }))
          : [];
        state.searchData = {
          ...state.searchData,
          [action.payload.index]: state.chosenData[action.payload.index]
            ? [...state.chosenData[action.payload.index], ...searched]
            : [...searched],
        };
      } else if (action.payload.type === 'products') {
        const searched = action.payload?.data?.data?.items.map((item: any) => {
          return {
            value: `${item?.fieldValues[0]?.value}!${item?.fieldValues[1]?.value}?${item?.fieldValues[2]?.value}`,
            label: item?.fieldValues[1]?.value,
          };
        });

        state.searchData = {
          ...state.searchData,
          [action.payload.index]: state.chosenData[action.payload.index]
            ? [...state.chosenData[action.payload.index], ...searched]
            : [...searched],
        };
      }

      if (action.payload.isDefault) {
        const chosenValues = action.payload?.data?.data?.items.map((item: any) => ({
          label: item?.fieldValues[1]?.value,
          value: `${item?.fieldValues[0]?.value}!${item?.fieldValues[1]?.value}?${item?.fieldValues[2]?.value}`,
        }));
        if (chosenValues?.length <= 50 || action.payload.type === 'kladr') {
          state.chosenData = {
            ...state.chosenData,
            [action.payload?.index]: chosenValues,
          };
          state.searchData = {
            ...state.searchData,
            [action.payload.index]: chosenValues,
          };
        } else {
          notify({ message: 'К акции можно добавить не более 50 товаров', type: 'error' });
        }
      }
    });
    builder.addCase(fetchDefaultKladr.fulfilled, (state, action) => {
      const chosenValues = action.payload?.data?.items?.map((item: any) => ({
        label: item.value,
        value: `${item.kladrId}!${item.value}`,
      }));

      state.chosenData = {
        ...state.chosenData,
        [action.payload?.index]: chosenValues,
      };

      state.searchData = {
        ...state.searchData,
        [action.payload.index]: chosenValues,
      };
    });
    builder
      .addCase(fetchGetExportModel.pending, (state) => {
        state.status.fetchingGetExportModel = true;
      })
      .addCase(fetchGetExportModel.fulfilled, (state, action) => {
        state.status.fetchingGetExportModel = false;
        state.modelExport = action.payload;

        downloadModalExport(action.payload);
      })
      .addCase(fetchGetExportModel.rejected, (state) => {
        state.status.fetchingGetExportModel = false;
      });
  },
});

// Selectors
type TSelectorState = { model: IModelState };

// Statuses
export const selectFetchingGetModel = (state: TSelectorState) =>
  state.model.status.fetchingGetModel;
export const selectFetchingGetModelSettings = (state: TSelectorState) =>
  state.model.status.fetchingGetModelSettings;
export const selectFetchingGetModelElements = (state: TSelectorState) =>
  state.model.status.fetchingGetModelElements;
export const selectFetchingGetModelElementFields = (state: TSelectorState) =>
  state.model.status.fetchingGetModelElementFields;
export const selectFetchingAddModelElement = (state: TSelectorState) =>
  state.model.status.fetchingAddModelElement;
export const selectFetchingModelElement = (state: TSelectorState) =>
  state.model.status.fetchingModelElement;
export const selectFetchingGetExportModel = (state: TSelectorState) =>
  state.model.status.fetchingGetExportModel;

// Modals
export const selectDelModelElementModal = (state: TSelectorState) =>
  state.model.modals.delModelElementModal;
export const selectNewModelElementModal = (state: TSelectorState) =>
  state.model.modals.newModelElementModal;
export const selectEditModelElementModal = (state: TSelectorState) =>
  state.model.modals.editModelElementModal;

export const selectModel = (state: TSelectorState) => state.model.model;
export const selectModelSettingsFilterable = (state: TSelectorState) =>
  state.model.modelSettings.filterable;
export const selectModelSettingsShownInList = (state: TSelectorState) =>
  state.model.modelSettings.shownInList;
export const selectModelSettingsSortable = (state: TSelectorState) =>
  state.model.modelSettings.sortable;
export const selectModelElements = (state: TSelectorState) => state.model.modelElements;
export const selectModelElementsTotal = (state: TSelectorState) => state.model.modelElementsTotal;
export const selectCurrentModelElement = (state: TSelectorState) => state.model.currentModelElement;
export const selectSelectedModelElements = (state: TSelectorState) =>
  state.model.selectedModelElements;
export const selectModelElementFields = (state: TSelectorState) => state.model.modelElementFields;
export const selectModelElementValues = (state: TSelectorState) => state.model.modelElementValues;
export const selectModelFiltersOptions = (state: TSelectorState) => state.model.filters;
export const selectModelFiltersToSend = (state: TSelectorState) => state.model.filtersToSend;
export const selectMediaCurrentId = (state: TSelectorState) => state.model.mediaId;
export const selectCurrentIndex = (state: TSelectorState) => state.model.currentIndex;
export const selectModalSearch = (state: any) => state.model.searchData;
export const selectChosenData = (state: any) => state.model.chosenData;
export const selectModelExport = (state: TSelectorState) => state.model.modelExport;

// Reducers and actions
export const {
  setCurrentModelElement,
  setSelectedModelElements,
  setOpenDelModelElementModal,
  setOpenNewModelElementModal,
  setOpenEditModelElementModal,
  setFiltersToSend,
  setFilters,
  setMediaId,
  setCurrentIndex,
  setModelSettingsFilterable,
  setModelElements,
  setSearchData,
  setChosenData,
} = modelSlice.actions;

export default modelSlice.reducer;
