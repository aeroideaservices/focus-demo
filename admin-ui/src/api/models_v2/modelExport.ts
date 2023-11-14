import { IModelExportRes, IModelReq } from '@/types/api/models_v2';

import api from '../instance';
import { URLS } from '../urls';

// Получение информации о последнем экспорте модели
export const apiGetModelExport = ({ modelCode }: IModelReq) =>
  api.get<IModelExportRes>(URLS.models_v2.modelExport.getModelExport(modelCode));

// Инициация экспорта модели
export const apiPostModelExport = ({ modelCode }: IModelReq) =>
  api.post(URLS.models_v2.modelExport.postModelExport(modelCode));
