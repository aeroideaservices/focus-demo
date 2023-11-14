import { UseFormReturnType } from '@mantine/form';

import { transliteration } from '@/utils/transliteration';

import { TField } from '../../../utils/getInitialValuesModelForm';

import { checkFieldOnSluggable } from './checkFieldOnSluggable';
import { getSluggableFieldIndex } from './getSluggableFieldIndex';
import { TSlugField } from './getSluggableObjects';

export const addTransliteration = (
  item: TField,
  slugObjArr: TSlugField[] | null,
  formObj: UseFormReturnType<{
    fields: TField[];
  }>,
  type: string
) => {
  if (checkFieldOnSluggable(item.code, slugObjArr)) {
    return (el: React.FormEvent<HTMLInputElement>) => {
      return type !== 'edit'
        ? formObj
            .getInputProps(`fields.${getSluggableFieldIndex(item.code, slugObjArr)}.value`)
            .onChange(transliteration(el.currentTarget.value, { onlyLower: true }))
        : undefined;
    };
  }

  return undefined;
};
