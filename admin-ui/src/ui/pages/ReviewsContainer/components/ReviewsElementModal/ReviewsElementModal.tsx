import { FC } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useSearchParams } from 'react-router-dom';
import { Modal, ModalProps, Text } from '@mantine/core';

import { getLimitInURL } from '@/utils/getLimitInURL';
import { getOffsetInURL } from '@/utils/getOffsetInURL';

import { LoaderOverlay } from '@/ui/organisms/LoaderOverlay/LoaderOverlay';

import ReviewFormBuilder from '../ReviewFormBuilder/ReviewFormBuilder';

import { AppDispatch } from '@/store';
import {
  fetchAddReviewItemAction,
  fetchEditReviewItemAction,
  fetchReviewsAction,
  selectFetchingReview,
  selectReviewId,
  selectReviewsItem,
  setOpenAddReviewsElementModal,
  setOpenEditReviewsElementModal,
} from '@/store/slices/reviews/reviews';

interface IModelElementModal extends ModalProps {
  title: string;
  type: 'new' | 'edit';
}

const ReviewsElementModal: FC<IModelElementModal> = ({ title, type, ...props }) => {
  const dispatch: AppDispatch = useDispatch();
  const [searchParams] = useSearchParams();
  const fetchingReview = useSelector(selectFetchingReview);
  const reviewsItem = useSelector(selectReviewsItem);
  const reviewId = useSelector(selectReviewId);

  const params = {
    params: {
      offset: getOffsetInURL(searchParams),
      limit: getLimitInURL(searchParams),
    },
  };

  const submitHandler = async (values: any) => {
    if (reviewId && type === 'edit') {
      await dispatch(
        fetchEditReviewItemAction({
          id: reviewId,
          data: {
            ...values,
          },
        })
      );
      await dispatch(fetchReviewsAction(params));
      dispatch(setOpenEditReviewsElementModal(false));
    } else if (type === 'new') {
      await dispatch(fetchAddReviewItemAction(values));
      await dispatch(fetchReviewsAction(params));
      dispatch(setOpenAddReviewsElementModal(false));
    }
  };

  return (
    <Modal
      centered
      size={765}
      {...props}
      title={
        <Text fw={700} fz="xl">
          {title}
        </Text>
      }
    >
      <LoaderOverlay visible={fetchingReview} />

      {reviewsItem && type === 'edit' && (
        <ReviewFormBuilder reviewsItem={reviewsItem} onSubmit={submitHandler} />
      )}

      {type === 'new' && <ReviewFormBuilder onSubmit={submitHandler} />}
    </Modal>
  );
};

export default ReviewsElementModal;
