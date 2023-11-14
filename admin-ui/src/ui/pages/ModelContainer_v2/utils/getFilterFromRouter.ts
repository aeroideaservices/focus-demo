import { isArray } from 'lodash';
import qs from 'qs';

export const getFilterFromRouter = (params: URLSearchParams) => {
  const result = qs.parse(params.toString()) as Record<string, unknown>;

  for (const key in result) {
    if (key !== 'limit' && key !== 'offset') {
      // Если фильтр строка, оборачиваем в массив
      if (typeof result[key] === 'string') {
        if (result[key] === 'Да' || result[key] === 'true') {
          result[key] = [true];
        } else if (result[key] === 'Нет' || result[key] === 'false') {
          result[key] = [false];
        } else {
          result[key] = [result[key] as string];
        }
      }

      // Если фильтр массив, то значения нужно проверить
      // и числа преобразовать в числа, строки оставить
      if (isArray(result[key])) {
        result[key] = (result[key] as string[] | number[] | boolean[]).map((item) => {
          if (item === 'Да') return (item = true);
          if (item === 'Нет') return (item = false);

          if (item === 'true') return (item = true);
          if (item === 'false') return (item = false);

          if (item === true) return (item = true);
          if (item === false) return (item = false);

          // TODO в целом это небольшой костыль для элементов у которых название
          // состоит только из цифр
          if (Number(item) && key !== 'title' && key !== 'name') return (item = Number(item));

          return item;
        });
      }
    } else {
      delete result.limit;
      delete result.offset;
    }
  }

  return result;
};
