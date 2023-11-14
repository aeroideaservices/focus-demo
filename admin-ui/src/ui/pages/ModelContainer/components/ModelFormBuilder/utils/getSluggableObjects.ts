import { TField } from '../../../utils/getInitialValuesModelForm';

export type TSlugField = {
  code: string;
  dependence: string;
  index: number;
};

export const getSluggableObjects = (fields: TField[]): TSlugField[] | null => {
  const sluggableObjArr: TSlugField[] = [];

  fields.map((field, index) => {
    if (field.sluggableOn) {
      sluggableObjArr.push({
        code: field.sluggableOn,
        dependence: field.code,
        index,
      });
    }
  });

  return sluggableObjArr.length > 0 ? sluggableObjArr : null;
};
