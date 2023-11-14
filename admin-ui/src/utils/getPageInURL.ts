import { PAGE } from '@/constants/common';

export const getPageInURL = (searchParams: URLSearchParams, constPage?: number): number => {
  const page = searchParams.get('page');

  return page ? Number(page) : constPage ? constPage : PAGE;
};
