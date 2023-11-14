import { TElementsRes, TModel, TQueryParamsNew } from '@/types';

import api from '../instance';
import { URLS } from '../urls';

export const apiGetModels = (params: TQueryParamsNew) =>
  api.get<TElementsRes<TModel>>(URLS.models.getModels, { params: params.params });
