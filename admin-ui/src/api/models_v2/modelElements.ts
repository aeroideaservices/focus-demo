import {
  IDelodelElementsBodyReq,
  IModelElementsBodyReq,
  IModelElementsReq,
} from '@/types/api/models_v2';
import { IListRes, TAnyOf, TObject } from '@/types/models_v2/models_v2';

import qs from 'qs';

import api from '../instance';
import { URLS } from '../urls';

// Создание элемента модели
export const apiAddModelElements = ({ modelCode, data }: IModelElementsReq<TAnyOf>) =>
  api.post<Record<string, string>>(URLS.models_v2.modelElements.addModelElements(modelCode), data);

// Получение списка элементов модели
export const apiGetModelElementsList = ({
  modelCode,
  params,
  data,
}: IModelElementsReq<IModelElementsBodyReq>) =>
  api.post<IListRes<TObject>>(
    `${URLS.models_v2.modelElements.getModelElementsList(modelCode)}?${qs.stringify(params)}`,
    data
  );

// Массовое удаление элементов модели
export const apiDelModelElements = ({
  modelCode,
  data,
}: IModelElementsReq<IDelodelElementsBodyReq>) =>
  api.post(URLS.models_v2.modelElements.delModelElements(modelCode), data);
