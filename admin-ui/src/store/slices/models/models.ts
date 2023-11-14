import { TModel } from '@/types';

import { createSlice } from '@reduxjs/toolkit';

import { apiGetModels } from '@/api';

import { createAxiosThunk } from '@/utils/asyncRequest';

interface IModelsState {
  status: {
    fetchingGetModels: boolean;
  };
  models: TModel[] | null;
  total: number;
}

const initialState: IModelsState = {
  status: {
    fetchingGetModels: false,
  },
  models: null,
  total: 0,
};
export const fetchGetModelsAction = createAxiosThunk('getModels', apiGetModels);

export const modelsSlice = createSlice({
  name: 'models',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(fetchGetModelsAction.pending, (state) => {
        state.status.fetchingGetModels = true;
      })
      .addCase(fetchGetModelsAction.fulfilled, (state, action) => {
        state.status.fetchingGetModels = false;
        state.models = action.payload.items;
        state.total = action.payload.total;
      })
      .addCase(fetchGetModelsAction.rejected, (state) => {
        state.status.fetchingGetModels = false;
      });
  },
});

// Selectors
type TSelectorState = { models: IModelsState };

// Statuses
export const selectFetchingGetModels = (state: TSelectorState) =>
  state.models.status.fetchingGetModels;

export const selectModels = (state: TSelectorState) => state.models.models;
export const selectModelsTotal = (state: TSelectorState) => state.models.total;

export default modelsSlice.reducer;
