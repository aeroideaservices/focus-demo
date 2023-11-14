import { ReviewStatus } from '@/constants/reviews';

import { TQueryParams } from '../common/common';

type TReviewRating = 1 | 2 | 3 | 4 | 5;

export interface IReview {
  id: string;
  productExternalId: number;
  productId: string;
  userId: string;
  userName: string;
  rating: TReviewRating;
  text: string;
  files: string[];
  usefulness: number;
  response: string;
  responseDate: string;
  createdDate: string;
  editingDate: string;
  activationDate: string;
  inactivationReason: string;
  inactivationReasonId: string;
  moderator: string;
  status: ReviewStatus;
}

export interface IReviewFormFields {
  productId: string;
  productExternalId: number | null;
  rating: TReviewRating;
  text: string | null;
  files: string[];
  userName: string;
  userId: string;
  status: ReviewStatus | '';
  inactivationReasonId: string;
  response: string | null;
  editingDate?: Date | null;
  createdDate?: Date | null;
  responseDate?: Date | null;
  activationDate?: Date | null;
  moderatorId: string;
  usefulness?: number;
}

export interface IReviewsListRequestBody {
  filter?: {
    status?: ReviewStatus[];
    rating?: TReviewRating;
    editingDate?: {
      from?: string;
      to?: string;
    };
  };
}

export interface IReviewsListRequest {
  data?: IReviewsListRequestBody;
  params: TQueryParams;
}

export interface InactivationOption {
  label: string;
  value: string;
}
