import { IToken } from '@/types';
import { InactivationOption, IReview, IReviewFormFields } from '@/types/reviews/reviews';

import { REVIEW_STATUS_ITEMS } from '@/constants/reviews';

export const getInitialValuesReviewForm = (
  token: IToken,
  inactivationOptions: InactivationOption[],
  reviewsItem?: IReview
): IReviewFormFields => {
  let base64Url = token.access_token.split('.')[1];
  let base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
  let jsonPayload = decodeURIComponent(
    window
      .atob(base64)
      .split('')
      .map(function (c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
      })
      .join('')
  );
  let tokenData = JSON.parse(jsonPayload.toString());

  const getDateString = (value?: string, fallback?: Date | null | undefined) =>
    value ? new Date(value) : fallback;

  return {
    createdDate: getDateString(reviewsItem?.createdDate, new Date()),
    editingDate: getDateString(reviewsItem?.editingDate, new Date()),
    productId: reviewsItem?.productId || '',
    rating: reviewsItem?.rating || 1,
    text: reviewsItem?.text || '',
    files: reviewsItem?.files || [],
    usefulness:
      reviewsItem?.usefulness && reviewsItem.usefulness !== 0
        ? reviewsItem.usefulness
        : reviewsItem?.usefulness === 0
        ? 0
        : undefined,
    userName: reviewsItem?.userName || '',
    userId: reviewsItem?.userId || '',
    status: REVIEW_STATUS_ITEMS.find(({ value }) => value === reviewsItem?.status)?.value || '',
    inactivationReasonId: reviewsItem?.inactivationReasonId || inactivationOptions[0]?.value || '',
    response: reviewsItem?.response || '',
    responseDate: getDateString(reviewsItem?.responseDate, null),
    activationDate: getDateString(reviewsItem?.activationDate, null),
    moderatorId: reviewsItem?.moderator || tokenData.sub,
    productExternalId: reviewsItem?.productExternalId || null,
  };
};
