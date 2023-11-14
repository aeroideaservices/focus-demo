import { FC } from 'react';
import { useDispatch, useSelector } from 'react-redux';

import ReviewsElementModal from '../ReviewsElementModal/ReviewsElementModal';

import { AppDispatch } from '@/store';
import {
  selectAddReviewsElementModal,
  selectEditReviewsElementModal,
  setOpenAddReviewsElementModal,
  setOpenEditReviewsElementModal,
} from '@/store/slices/reviews/reviews';

const ReviewsTableModals: FC = () => {
  const dispatch: AppDispatch = useDispatch();
  const editReviewsElementModel = useSelector(selectEditReviewsElementModal);
  const addReviewsElementModel = useSelector(selectAddReviewsElementModal);

  return (
    <>
      <ReviewsElementModal
        type="new"
        title="Добавление отзыва"
        opened={addReviewsElementModel}
        onClose={() => dispatch(setOpenAddReviewsElementModal(false))}
      />

      <ReviewsElementModal
        type="edit"
        title="Изменение отзыва"
        opened={editReviewsElementModel}
        onClose={() => dispatch(setOpenEditReviewsElementModal(false))}
      />
    </>
  );
};

export default ReviewsTableModals;
