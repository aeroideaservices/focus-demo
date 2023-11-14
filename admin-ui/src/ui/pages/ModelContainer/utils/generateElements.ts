import { TModel, TModelElement } from '@/types';

import { getDataFormat } from './getDataFormat';
import { getViewType } from './getViewType';

export const generateElements = (rows: TModelElement[], showTypes: TModel[]) => {
  const elements: Record<string, string>[] = [];

  rows.map((row) => {
    const element: Record<string, string> = {};

    row.fieldValues.map((field) => {
      const type = getViewType(showTypes, field.code);

      element[field.code] = getDataFormat(field.value, type);
    });

    elements.push(element);
  });

  return elements;
};
