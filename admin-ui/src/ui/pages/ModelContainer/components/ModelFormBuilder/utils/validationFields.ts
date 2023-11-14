import { ViewTypeEnum } from '@/types';

import { OutputData } from '@editorjs/editorjs';

import {
  CODE_REGEXP,
  PHONE_LENGHT_REGEXP,
  POSITION_REGEXP,
  STRING_EMAIL_REGEXP,
  STRING_RELATIVE_OR_ABSOLUTE_LINK,
} from '@/constants/validationSchemas';
import { validationTexts } from '@/constants/validationTexts';

import { TField } from '../../../utils/getInitialValuesModelForm';

export const validationFields = (
  value: string | undefined,
  array: {
    fields: TField[];
  },
  path: string,
  type: string
) => {
  const field = array.fields[parseInt(path.split('.')[1])];

  // Если поле disabled то не валидируем его
  if (field.disabled && !(field.code === 'code')) {
    return null;
  }

  // Проверка что поле обязательно
  if (!value && field.required) {
    return validationTexts.REQUIRED;
  }

  // Проверка поля телефона
  if (field.type === ViewTypeEnum.PHONE) {
    return !value || value?.match(PHONE_LENGHT_REGEXP) ? null : validationTexts.PHONE_ERROR;
  }

  // Проверка поля email
  if (field.type === ViewTypeEnum.EMAIL) {
    return !value || value?.match(STRING_EMAIL_REGEXP) ? null : validationTexts.EMAIL_ERROR;
  }

  // Проверка поля ссылка
  if (field.code === 'link') {
    return !value || value?.match(STRING_RELATIVE_OR_ABSOLUTE_LINK)
      ? null
      : validationTexts.LINK_ERROR;
  }

  // Проверка поля код
  if (field.code === 'code' && type === 'new') {
    return !value || value?.match(CODE_REGEXP) ? null : validationTexts.CODE;
  }

  // Проверка поля позиции
  if (field.code === 'position') {
    return !value || String(value).match(POSITION_REGEXP) ? null : validationTexts.POSITION_ERROR;
  }

  // Проверка полей с jsEditor
  if (
    field.type === ViewTypeEnum.HTML &&
    field.formField &&
    field.formField.code === 'editor_js' &&
    field.required &&
    value
  ) {
    const data: OutputData = JSON.parse(value);

    return data.blocks.length !== 0 ? null : validationTexts.REQUIRED;
  }

  // Проверка ссылки через formField
  if (field.formField && field.formField?.opts?.format === 'uri') {
    if (field.code === 'filtered_catalog_link') {
      return !value || value?.match(field.formField?.opts?.pattern)
        ? null
        : field.formField?.opts?.validationErrorText;
    } else {
      return !value || value?.match(STRING_RELATIVE_OR_ABSOLUTE_LINK)
        ? null
        : validationTexts.LINK_ERROR;
    }
  }

  // Проверка html контента
  if (field.type === ViewTypeEnum.HTML) {
    return field.required && !value ? validationTexts.REQUIRED : null;
  }

  return null;
};
