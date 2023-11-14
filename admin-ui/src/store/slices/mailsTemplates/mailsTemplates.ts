import { TMailsTemplate } from '@/types';

import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { omit } from 'lodash';

import {
  apiDelMailsTemplate,
  apiDelMailsTemplates,
  apiGetMailTemplates,
  tryAddMailTemplate,
  tryGetMailTemplate,
  tryPutMailTemplate,
} from '@/api/mailsTemplates/mailsTemplates';

import { createAxiosThunk } from '@/utils/asyncRequest';
import notify from '@/utils/notify';

import { LIMIT, OFFSET } from '@/constants/common';

interface IMailsTemplatesState {
  status: {
    fetchingMailsTemplates: boolean;
    fetchingAddMailsTemplates: boolean;
  };
  modals: {
    delMailsTempalateModal: boolean;
    delMailsTempalatesModal: boolean;
  };
  items: TMailsTemplate[] | null;
  total: number | null;
  limit: number;
  offset: number;
}

const initialState: IMailsTemplatesState = {
  status: {
    fetchingMailsTemplates: false,
    fetchingAddMailsTemplates: false,
  },
  modals: {
    delMailsTempalateModal: false,
    delMailsTempalatesModal: false,
  },
  items: null,
  total: null,
  limit: LIMIT,
  offset: OFFSET,
};

export const fetchMailsTemplatesAction = createAxiosThunk('/mailTemplates', apiGetMailTemplates);
export const fetchDelMailsTemplateAction = createAxiosThunk(
  '/delMailsTemplate',
  apiDelMailsTemplate
);
export const fetchMultiDelMailsTemplateAction = createAxiosThunk(
  '/multiDelMailsTemplate',
  apiDelMailsTemplates
);

export const fetchMailTemplateAction = async (
  id: string
): Promise<Omit<TMailsTemplate, 'id'> | null> => {
  const result = await tryGetMailTemplate(id);
  if (result?.status === 200) {
    return omit(result.data, 'id');
  } else {
    return null;
  }
};

export const putMailTemplateAction = async (
  id: string,
  data: Partial<TMailsTemplate>
): Promise<boolean | null> => {
  const result = await tryPutMailTemplate(id, data);
  if (result?.status === 204) {
    notify({ message: 'Шаблон изменен', type: 'success' });
    return true;
  } else {
    return null;
  }
};

export const addMailTemplateAction = async (
  data: Partial<TMailsTemplate>
): Promise<boolean | null> => {
  const result = await tryAddMailTemplate(data);
  if (result?.status === 201) {
    notify({ message: 'Шаблон добавлен', type: 'success' });
    return true;
  } else {
    return null;
  }
};

export const mailsTemplatesSlice = createSlice({
  name: 'mailTemplates',
  initialState,
  reducers: {
    setOpenDelMailsTemplateModal: (state, action: PayloadAction<boolean>) => {
      state.modals.delMailsTempalateModal = action.payload;
    },
    setOpenDelMailsTemplatesModal: (state, action: PayloadAction<boolean>) => {
      state.modals.delMailsTempalatesModal = action.payload;
    },
    setMailsTemplatesLimit: (state, action: PayloadAction<number>) => {
      state.limit = action.payload;
    },
    setMailsTemplatesOffset: (state, action: PayloadAction<number>) => {
      state.offset = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchMailsTemplatesAction.pending, (state) => {
        state.status.fetchingMailsTemplates = true;
      })
      .addCase(fetchMailsTemplatesAction.fulfilled, (state, action) => {
        state.status.fetchingMailsTemplates = false;
        state.items = action.payload.items;
        state.total = action.payload.total;
      })
      .addCase(fetchMailsTemplatesAction.rejected, (state) => {
        state.status.fetchingMailsTemplates = false;
      });
    builder
      .addCase(fetchDelMailsTemplateAction.pending, (state) => {
        state.status.fetchingMailsTemplates = true;
      })
      .addCase(fetchDelMailsTemplateAction.fulfilled, (state) => {
        state.status.fetchingMailsTemplates = false;
        state.modals.delMailsTempalateModal = false;

        notify({ message: 'Почтовый шаблон удален', type: 'success' });
      })
      .addCase(fetchDelMailsTemplateAction.rejected, (state) => {
        state.status.fetchingMailsTemplates = false;
        state.modals.delMailsTempalateModal = false;
      });
    builder
      .addCase(fetchMultiDelMailsTemplateAction.pending, (state) => {
        state.status.fetchingMailsTemplates = true;
      })
      .addCase(fetchMultiDelMailsTemplateAction.fulfilled, (state) => {
        state.status.fetchingMailsTemplates = false;
        state.modals.delMailsTempalatesModal = false;

        notify({ message: 'Почтовые шаблоны удалены', type: 'success' });
      })
      .addCase(fetchMultiDelMailsTemplateAction.rejected, (state) => {
        state.status.fetchingMailsTemplates = false;
        state.modals.delMailsTempalatesModal = false;
      });
  },
});

// Selectors

type TSelectorState = { mailsTemplates: IMailsTemplatesState };

// Modals
export const selectDelMailsTemplateModal = (state: TSelectorState) =>
  state.mailsTemplates.modals.delMailsTempalateModal;

export const selectDelMailsTemplatesModal = (state: TSelectorState) =>
  state.mailsTemplates.modals.delMailsTempalatesModal;
// Statuses
export const selectFetchingMailsTemplatesStatus = (state: TSelectorState) =>
  state.mailsTemplates.status.fetchingMailsTemplates;

export const selectMailsTemplatesItems = (state: TSelectorState) => state.mailsTemplates.items;
export const selectMailsTemplatesTotal = (state: TSelectorState) => state.mailsTemplates.total;
export const selectMailsTemplatesLimit = (state: TSelectorState) => state.mailsTemplates.limit;
export const selectMailsTemplatesOffset = (state: TSelectorState) => state.mailsTemplates.offset;

// Reducers and actions

export const {
  setMailsTemplatesLimit,
  setMailsTemplatesOffset,
  setOpenDelMailsTemplateModal,
  setOpenDelMailsTemplatesModal,
} = mailsTemplatesSlice.actions;

export default mailsTemplatesSlice.reducer;
