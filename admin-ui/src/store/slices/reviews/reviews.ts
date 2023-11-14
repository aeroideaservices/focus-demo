import { InactivationOption, IReview } from '@/types/reviews/reviews';

import { SelectItemProps } from '@mantine/core';
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

import {
  apiAddReviewItem,
  apiEditReviewItem,
  apiGetInactivationOptions,
  apiReviewsItem,
  apiReviewsList,
} from '@/api/reviews/reviews';

import { createAxiosThunk } from '@/utils/asyncRequest';
import notify from '@/utils/notify';
import { setFormatDate } from '@/utils/setFormatDate';

import { DEFAULT_DATE_OPTIONS, LIMIT, OFFSET } from '@/constants/common';

interface IReviewsState {
  status: {
    fetchingGetReviews: boolean;
    fetchingReviewItem: boolean;
  };
  total: number;
  limit: string;
  offset: string;
  modals: {
    editReviewsElementModal: boolean;
    addReviewsElementModal: boolean;
  };
  reviews: IReview[];
  reviewItem: IReview | null;
  reviewId: string | any;
  inactivationOptions: InactivationOption[];
  articleSearch: {
    fetching: boolean;
    results: SelectItemProps[];
  };
}

const initialState: IReviewsState = {
  status: {
    fetchingGetReviews: false,
    fetchingReviewItem: false,
  },
  total: 0,
  limit: LIMIT.toString(),
  offset: OFFSET.toString(),
  modals: {
    editReviewsElementModal: false,
    addReviewsElementModal: false,
  },
  reviews: [],
  reviewItem: null,
  reviewId: null,
  inactivationOptions: [],
  articleSearch: {
    fetching: false,
    results: [],
  },
};

export const fetchReviewsAction = createAxiosThunk('/reviews', apiReviewsList);
export const fetchReviewsItemAction = createAxiosThunk('/reviewsItem', apiReviewsItem);
export const fetchEditReviewItemAction = createAxiosThunk('/editReviewItem', apiEditReviewItem);
export const fetchAddReviewItemAction = createAxiosThunk('/addReviewItem', apiAddReviewItem);
export const fetchInactivationOptions = createAxiosThunk(
  '/inactivationReasonOptions',
  apiGetInactivationOptions
);

export const reviewsSlice = createSlice({
  name: 'reviews',
  initialState,
  reducers: {
    setOpenEditReviewsElementModal: (state, action: PayloadAction<boolean>) => {
      state.modals.editReviewsElementModal = action.payload;
    },
    setCurrentReviewId: (state, action: PayloadAction<string>) => {
      state.reviewId = action.payload;
    },
    setOpenAddReviewsElementModal: (state, action: PayloadAction<boolean>) => {
      state.modals.addReviewsElementModal = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchReviewsAction.pending, (state) => {
        state.status.fetchingGetReviews = true;
      })
      .addCase(fetchReviewsAction.fulfilled, (state, action) => {
        state.reviews = action.payload.items.map((item) => ({
          ...item,
          activationDate: setFormatDate(item.activationDate, DEFAULT_DATE_OPTIONS, 'ru-RU'),
          responseDate: setFormatDate(item.responseDate, DEFAULT_DATE_OPTIONS, 'ru-RU'),
          createdDate: setFormatDate(item.createdDate, DEFAULT_DATE_OPTIONS, 'ru-RU'),
          editingDate: setFormatDate(item.editingDate, DEFAULT_DATE_OPTIONS, 'ru-RU'),
        }));
        state.total = action.payload.total;
        state.status.fetchingGetReviews = false;
      });
    builder
      .addCase(fetchReviewsItemAction.pending, (state) => {
        state.status.fetchingReviewItem = true;
      })
      .addCase(fetchReviewsItemAction.fulfilled, (state, action) => {
        state.reviewItem = action.payload;
        state.status.fetchingReviewItem = false;
      })
      .addCase(fetchReviewsItemAction.rejected, (state) => {
        state.status.fetchingReviewItem = false;
      });
    builder.addCase(fetchEditReviewItemAction.fulfilled, () => {
      notify({ message: 'Отзыв изменен', type: 'success' });
    });
    builder.addCase(fetchAddReviewItemAction.fulfilled, () => {
      notify({ message: 'Отзыв создан', type: 'success' });
    });
    builder.addCase(fetchInactivationOptions.fulfilled, (state, action) => {
      state.inactivationOptions = action.payload.items.map((item) => ({
        value: String(item.id) || '',
        label: String(item.name) || '',
      }));
    });
  },
});

// Selectors
type TSelectorState = { reviews: IReviewsState };

// Statuses
export const selectFetchingReviewsAction = (state: TSelectorState) =>
  state.reviews.status.fetchingGetReviews;
export const selectFetchingReview = (state: TSelectorState) =>
  state.reviews.status.fetchingReviewItem;

// modals
export const selectEditReviewsElementModal = (state: TSelectorState) =>
  state.reviews.modals.editReviewsElementModal;
export const selectAddReviewsElementModal = (state: TSelectorState) =>
  state.reviews.modals.addReviewsElementModal;
export const selectReviewsTotal = (state: TSelectorState) => state.reviews.total;
export const selectReviews = (state: TSelectorState) => state.reviews.reviews;
export const selectReviewsItem = (state: TSelectorState) => state.reviews.reviewItem;
export const selectReviewId = (state: TSelectorState) => state.reviews.reviewId;

export const selectInactivationOptions = (state: TSelectorState) =>
  state.reviews.inactivationOptions;

// reducers and actions

export const { setOpenEditReviewsElementModal, setCurrentReviewId, setOpenAddReviewsElementModal } =
  reviewsSlice.actions;

export default reviewsSlice.reducer;
