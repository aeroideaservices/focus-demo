import { TSlugField } from './getSluggableObjects';

export const getSluggableFieldCode = (
  code: string,
  sluggableObjects: TSlugField[] | null
): string | null => {
  if (sluggableObjects && sluggableObjects.length > 0) {
    const filteredOblects = sluggableObjects.filter((obj) => obj.code === code);
    return filteredOblects.length > 0 ? filteredOblects[0].dependence : null;
  }

  return null;
};
