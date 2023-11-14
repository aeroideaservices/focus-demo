import {
  TAddModelElementReq,
  TChangeModelElementsReq,
  TCodeAndHeaders,
  TDelModelElementsReq,
  TElementsRes,
  TGetModelElementsReq,
  TGetModelSettingsRes,
  TModel,
  TModelElement,
  TModelElementFieldsReq,
  TModelElementReq,
  TModelElementValuesReq,
  TModelExport,
} from '@/types';

import qs from 'qs';

import api from '../instance';
import { URLS } from '../urls';

export const apiGetModel = (modelCode: TCodeAndHeaders) =>
  api.get<TModel>(URLS.models.getModel(modelCode.code));

export const apiGetModelSettings = (modelCode: TCodeAndHeaders) =>
  api.get<TGetModelSettingsRes>(URLS.models.getModelSettings(modelCode.code));

export const apiGetModelElements = ({ modelCode, params, data }: TGetModelElementsReq) =>
  api.post<TElementsRes<TModelElement>>(
    `${URLS.models.getModelElementsList(modelCode)}?${qs.stringify(params)}`,
    {
      ...data,
    }
  );

export const apiGetModelElementFieldValues = ({ modelCode, fieldCode }: TModelElementValuesReq) =>
  api.get<TElementsRes<string>>(URLS.models.getModelFieldValues(modelCode, fieldCode), {
    params: {
      limit: 100,
      offset: 0,
    },
  });

export const apiDelModelElement = ({ modelCode, elementId }: TModelElementReq) =>
  api.delete(URLS.models.delModelElement(modelCode, elementId));

export const apiDelModelElements = ({ modelCode, data }: TDelModelElementsReq) =>
  api.post(URLS.models.delModelElements(modelCode), { ...data });

export const apiGetModelElementFields = (data: TModelElementFieldsReq) =>
  api.get<TModel[]>(URLS.models.getModelFields(data.modelCode));

export const apiAddModelElement = ({ modelCode, data }: TAddModelElementReq) =>
  api.post<{ id: string }>(URLS.models.addModelElement(modelCode), { ...data });

export const apiGetModelElement = ({ modelCode, elementId }: TModelElementReq) =>
  api.get<TModelElement>(URLS.models.getModelElement(modelCode, elementId));

export const apiChangeModelElement = ({ modelCode, elementId, data }: TChangeModelElementsReq) =>
  api.put<TModelElement>(URLS.models.changeModelElement(modelCode, elementId), { ...data });

export const apiModelFieldValues = ({ modelCode, elementId, params }: TChangeModelElementsReq) =>
  api.get<TModelElement>(URLS.models.getModelFieldValues(modelCode, elementId), { params });

export const apiExportModel = (modelCode: string) =>
  api.post<TModelElement>(URLS.models.postExportModel(modelCode));

export const apiGetExportModel = (modelCode: string) =>
  api.get<TModelExport>(URLS.models.getExportModel(modelCode));

export const apiGetDefaultKladr = ({ params }: any) =>
  api.get(`${process.env.GEO_API_URL}/${URLS.models.getDefaultKladr}`, { params });
