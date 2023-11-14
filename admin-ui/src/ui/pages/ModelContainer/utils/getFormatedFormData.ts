import { TModelElement, TModelField, ViewTypeEnum } from '@/types';

import { isArray } from 'lodash';

import { TField } from './getInitialValuesModelForm';

export const getFormatedModelFormData = (values: TField[]): TModelElement => {
  const fields: TField[] = values;
  const fieldValues: TModelField[] = [];

  const getTransformValue = (field: TField) => {
    if (field.type === ViewTypeEnum.DATE || field.type === ViewTypeEnum.DATETIME) {
      return field.value;
    }

    if (field.type === ViewTypeEnum.CHECKBOX) {
      return String(field.checked);
    }

    if (field.type === ViewTypeEnum.INT) {
      return field.value ? String(field.value) : '0';
    }

    if (
      field.type === ViewTypeEnum.MODELSCOLLECTION ||
      field.type === ViewTypeEnum.MODEL ||
      field.type === ViewTypeEnum.MEDIA
    ) {
      return field.value ? field.value : null;
    }

    if (field.type === ViewTypeEnum.SLICEOFUUID || field.type === ViewTypeEnum.SLICEOFSTRINGS) {
      if (field.value && isArray(field.value)) {
        return field.value.length > 0 ? field.value.join(',') : null;
      } else {
        return field.value ? field.value : null;
      }
    }

    if (field.type === ViewTypeEnum.PHONE) {
      const regexp = /[\s()-]/g;

      return field.value ? field.value.replace(regexp, '') : '';
    }

    return String(field.value);
  };

  fields.map((field) => {
    const fieldValue = {
      code: field.code,
      value: getTransformValue(field),
    };

    fieldValues.push(<TModelField>fieldValue);
  });

  return { fieldValues };
};
