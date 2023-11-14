import { TSlugField } from './getSluggableObjects';

export const checkFieldOnSluggable = (
  code: string,
  sluggableObjects: TSlugField[] | null
): boolean => {
  if (sluggableObjects && sluggableObjects.length > 0) {
    return sluggableObjects.filter((obj) => obj.code === code).length > 0 ? true : false;
  }

  return false;
};
