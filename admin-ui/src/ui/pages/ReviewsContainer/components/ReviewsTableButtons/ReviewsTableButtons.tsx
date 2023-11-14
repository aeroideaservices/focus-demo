import { FC } from 'react';
import { useDispatch } from 'react-redux';
import { ActionIcon, Group } from '@mantine/core';
import { IconPencil } from '@tabler/icons-react';

import { AppDispatch } from '@/store';
import {
  fetchReviewsItemAction,
  setCurrentReviewId,
  setOpenEditReviewsElementModal,
} from '@/store/slices/reviews/reviews';

const ReviewsTableButtons: FC = ({ ...props }) => {
  const dispatch: AppDispatch = useDispatch();

  const changeHandler = async () => {
    const { id: elementId } = props as Record<string, string>;

    await dispatch(fetchReviewsItemAction({ id: elementId }));
    dispatch(setOpenEditReviewsElementModal(true));
    dispatch(setCurrentReviewId(elementId));
  };

  return (
    <Group
      position={'right'}
      sx={{
        flexWrap: 'nowrap',
      }}
    >
      <ActionIcon name="Изменить" title="Изменить" onClick={changeHandler}>
        <IconPencil size={20} color="gray" />
      </ActionIcon>
    </Group>
  );
};

export default ReviewsTableButtons;
