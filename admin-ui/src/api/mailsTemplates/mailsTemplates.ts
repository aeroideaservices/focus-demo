import { TGetTMailsTemplate, TMailsTemplate, TQueryParams } from 'src/types';

import { axiosErrorHandler } from '@/utils/axiosErrorHandler';

import api from '../instance';
import { URLS } from '../urls';

export const apiGetMailTemplates = (params: TQueryParams) =>
  api.get<TGetTMailsTemplate>(URLS.mailsTemplate.getMailsTemplates, { params });

export const apiDelMailsTemplate = (id: string) =>
  api.delete<{ id: string }>(URLS.mailsTemplate.delMailsTemplateById(id));

export const apiDelMailsTemplates = (mailTemplatesIds: string[]) =>
  api.delete<{ id: string }>(URLS.mailsTemplate.getMailsTemplates, {
    params: { mailTemplatesIds },
  });

export const apiGetMailTemplate = (id: string) =>
  api.get<TMailsTemplate>(URLS.mailsTemplate.getMailTemplate(id));

export const apiPutMailTemplate = (id: string, data: Partial<TMailsTemplate>) =>
  api.put<TMailsTemplate>(URLS.mailsTemplate.getMailTemplate(id), { ...data });

export const apiAddMailTemplate = (data: Partial<TMailsTemplate>) =>
  api.post<TMailsTemplate>(URLS.mailsTemplate.getMailsTemplates, { ...data });

/*TRY ...CATCH */

export const tryGetMailTemplate = (id: string) =>
  apiGetMailTemplate(id)
    .then((res) => res)
    .catch(axiosErrorHandler);

export const tryPutMailTemplate = (id: string, data: Partial<TMailsTemplate>) =>
  apiPutMailTemplate(id, data)
    .then((res) => res)
    .catch(axiosErrorHandler);

export const tryAddMailTemplate = (data: Partial<TMailsTemplate>) =>
  apiAddMailTemplate(data)
    .then((res) => res)
    .catch(axiosErrorHandler);
