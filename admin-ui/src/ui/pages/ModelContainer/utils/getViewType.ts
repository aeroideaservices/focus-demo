import { TModel } from '@/types';

export const getViewType = (types: TModel[], code: string) => {
  let type: string | undefined = '';

  types.map((el) => {
    if (el.code === code) type = el.viewType;
  });

  return type;
};
