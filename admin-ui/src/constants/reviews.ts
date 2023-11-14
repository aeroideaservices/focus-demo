export enum ReviewStatus {
  WAIT = 'wait',
  ACTIVE = 'active',
  INACTIVE = 'inactive',
}

export const REVIEW_STATUS_LABELS: { [key in ReviewStatus]: string } = {
  [ReviewStatus.WAIT]: 'На модерации',
  [ReviewStatus.ACTIVE]: 'Активен',
  [ReviewStatus.INACTIVE]: 'Деактивирован',
};

export enum ReviewSortField {
  PRODUCT_ID = 'product_external_id',
  RATING = 'rating',
  STATUS = 'status',
  USER_ID = 'user_id',
  RESPONSE = 'response',
  RESPONSE_DATE = 'response_date',
  CREATED_DATE = 'created_date',
  EDITING_DATE = 'editing_date',
  ACTIVATION_DATE = 'activation_date',
  MODERATOR = 'moderator',
}

export const REVIEW_STATUS_ITEMS = [
  {
    value: ReviewStatus.ACTIVE,
    label: REVIEW_STATUS_LABELS[ReviewStatus.ACTIVE],
  },
  {
    value: ReviewStatus.INACTIVE,
    label: REVIEW_STATUS_LABELS[ReviewStatus.INACTIVE],
  },
  {
    value: ReviewStatus.WAIT,
    label: REVIEW_STATUS_LABELS[ReviewStatus.WAIT],
  },
];

export const REVIEWS_SEARCH_PLACEHOLDER = 'Начните вводить Артикул, ID покупателя или ID отзыва';
export const REVIEWS_USERS_FILES_DIR_ID = '305a4670-f566-4d42-ba94-075fab4ec17b';
