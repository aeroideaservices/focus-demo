import { TSlugField } from './getSluggableObjects';

export const getSluggableFieldIndex = (
  code: string,
  sluggableObjects: TSlugField[] | null
): number | null => {
  if (sluggableObjects && sluggableObjects.length > 0) {
    const filteredOblects = sluggableObjects.filter((obj) => obj.code === code);
    return filteredOblects.length > 0 ? filteredOblects[0].index : null;
  }

  return null;
};
