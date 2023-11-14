import { IReview } from '@/types/reviews/reviews';

import { REVIEW_STATUS_LABELS } from '@/constants/reviews';

export const getDisplayReviews = (reviews: IReview[]) =>
  reviews.map((review) => ({ ...review, status: REVIEW_STATUS_LABELS[review.status] }));
