import { TElementsRes, TQueryParams } from '@/types';
import { TObject } from '@/types/models_v2/models_v2';
import { IReview, IReviewsListRequest } from '@/types/reviews/reviews';

import qs from 'qs';

import api from '../instance';
import { URLS } from '../urls';

export const apiReviewsList = (params: IReviewsListRequest) =>
  api.post<TElementsRes<IReview>>(
    URLS.reviews.reviewsList,
    { ...params.data },
    { params: { ...params.params } }
  );

export const apiReviewsItem = (data: any) => api.get<IReview>(URLS.reviews.getReviewsById(data.id));

export const apiEditReviewItem = (data: any) =>
  api.patch<TElementsRes<IReview>>(URLS.reviews.getEditReviewItemById(data.id), { ...data.data });

export const apiAddReviewItem = (data: any) =>
  api.post<TElementsRes<IReview>>(URLS.reviews.addReview, { ...data });

export const apiGetInactivationOptions = (params: TQueryParams) =>
  api.post<TElementsRes<TObject>>(
    `${URLS.models_v2.modelElements.getModelElementsList('inactivation-reasons')}?${qs.stringify(
      params
    )}`,
    {}
  );
