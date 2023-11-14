import { IModelElementReq } from '@/types/api/models_v2';
import { TAnyOf, TObject } from '@/types/models_v2/models_v2';

import api from '../instance';
import { URLS } from '../urls';

// Получение элемента модели
export const apiGetModelElement = ({ modelCode, modelElementId }: IModelElementReq<undefined>) =>
  api.get<TObject>(URLS.models_v2.modelElement.getModelElement(modelCode, modelElementId));

// Изменение элемента модели
export const apiPutModelElement = ({ modelCode, modelElementId, data }: IModelElementReq<TAnyOf>) =>
  api.put(URLS.models_v2.modelElement.putModelElement(modelCode, modelElementId), data);

// Удаление элемента модели
export const apiDelModelElement = ({ modelCode, modelElementId }: IModelElementReq<undefined>) =>
  api.delete(URLS.models_v2.modelElement.delModelElement(modelCode, modelElementId));
