import { TModel, TModelField, ViewTypeEnum } from '@/types';

import { randomId } from '@mantine/hooks';

export type TField = {
  formField?: any;
  block?: string;
  disabled?: boolean;
  key: string;
  label: string;
  name: string;
  code: string;
  type?: ViewTypeEnum;
  value?: string;
  checked?: boolean;
  required?: boolean;
  sluggableOn?: string;
};

export const getInitialValuesModelForm = (
  type: string,
  options: TModel[],
  values?: TModelField[]
) => {
  const fields: TField[] = [];

  const getValue = (valuesArr: TModelField[], code: string) => {
    const filtered = valuesArr.filter((el) => el.code === code);

    return filtered[0].value;
  };

  options.map((option) => {
    let value: string | Date | boolean | null | number = values
      ? getValue(values, option.code)
      : option.value
      ? option.value
      : '';

    if (option.viewType === ViewTypeEnum.DATETIME || option.viewType === ViewTypeEnum.DATE) {
      const setedValue = values ? getValue(values, option.code) : '';
      value = setedValue ? new Date(setedValue) : '';
    }

    if (option.viewType === ViewTypeEnum.PHONE) {
      const setedValue = values ? getValue(values, option.code) : '';
      value = setedValue;
    }

    if (option.viewType === ViewTypeEnum.CHECKBOX) {
      const setedValue = values && getValue(values, option.code);
      value = setedValue === 'true' ? true : false;
    }

    if (
      option.viewType === ViewTypeEnum.NUMERIC ||
      option.viewType === ViewTypeEnum.INT ||
      option.viewType === ViewTypeEnum.FLOAT
    ) {
      const setedValue = values ? Number(getValue(values, option.code)) : 0;
      value = setedValue;
    }

    if (!option.viewType) {
      value = option.value ? option.value : '';
    }

    if (
      option.viewType === ViewTypeEnum.MODEL ||
      option.viewType === ViewTypeEnum.SLICEOFUUID ||
      option.viewType === ViewTypeEnum.SLICEOFSTRINGS
    ) {
      value = value ? value : '';
    }

    if (option.viewType === ViewTypeEnum.MODELSCOLLECTION) {
      const setedValue = values ? getValue(values, option.code) : '';
      value = setedValue;
    }

    if (!(type == 'new' && option.primary)) {
      fields.push({
        block: option.block,
        disabled: option.disabled,
        key: randomId(),
        label: option.name,
        name: option.code,
        code: option.code,
        type: option.viewType,
        required: option.required,
        formField: option.formField,
        [option.viewType !== ViewTypeEnum.CHECKBOX ? 'value' : 'checked']: value,
        sluggableOn: option.sluggableOn,
      });
    }
  });

  return fields;
};
