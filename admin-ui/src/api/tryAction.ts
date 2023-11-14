import { AxiosResponse } from 'axios';

import { axiosErrorHandler } from '@/utils/axiosErrorHandler';

export const tryAction = <R = unknown>(response: Promise<AxiosResponse<R, unknown>>) =>
  response.then((res) => res.data).catch(axiosErrorHandler);

export const tryActionStatus = <R = unknown>(response: Promise<AxiosResponse<R, unknown>>) =>
  response.then((res) => res.status).catch(axiosErrorHandler);
