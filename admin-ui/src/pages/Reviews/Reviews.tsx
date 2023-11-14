import { FC } from 'react';
import { useDocumentTitle } from '@mantine/hooks';

import { TITLE_REVIEWS } from '@/constants/titles';

import ReviewsContainer from '@/ui/pages/ReviewsContainer/ReviewsContainer';

const Reviews: FC = () => {
  useDocumentTitle(TITLE_REVIEWS);

  return <ReviewsContainer />;
};

export default Reviews;
