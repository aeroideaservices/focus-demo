import { setFormatDate } from '@/utils/setFormatDate';

export const getDataFormat = (data: string, type: string) => {
  switch (type) {
    case 'checkbox':
      return data === 'true' ? 'Да' : 'Нет';
    case 'datetime':
      return setFormatDate(data, {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
      });
    default:
      return data;
  }
};
