import { TModel } from '@/types';

export const getSortableKeys = (models: TModel[] | null) => {
  const keys: string[] = [];

  if (models) models.map((model) => keys.push(model.code));

  return keys;
};
