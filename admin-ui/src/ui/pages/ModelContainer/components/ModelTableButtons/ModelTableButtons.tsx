import { FC } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { ActionIcon, Group } from '@mantine/core';
import { IconEye, IconPencil, IconTrash } from '@tabler/icons-react';

import { AppDispatch } from '@/store';
import {
  fetchGetModelElementAction,
  fetchGetModelElementPreviewAction,
  fetchModelElementFieldsAction,
  selectFetchingModelElement,
  setCurrentModelElement,
  setOpenDelModelElementModal,
  setOpenEditModelElementModal,
} from '@/store/slices/models/model';
import { selectCurrentService } from '@/store/slices/service/service';

const ModelTableButtons: FC = ({ ...props }) => {
  const dispatch: AppDispatch = useDispatch();
  const urlParams = useParams();
  const modelCode = urlParams.modelCode;
  const service = useSelector(selectCurrentService);
  const fetchingModelElement = useSelector(selectFetchingModelElement);

  const changeHandler = async () => {
    const { id: elementId } = props as Record<string, string>;

    if (modelCode && service) {
      await dispatch(fetchModelElementFieldsAction({ modelCode }));
      await dispatch(fetchGetModelElementAction({ modelCode, elementId }));

      dispatch(setCurrentModelElement({ ...props }));
      dispatch(setOpenEditModelElementModal(true));
    }
  };

  const deleteHandler = () => {
    dispatch(setCurrentModelElement({ ...props }));
    dispatch(setOpenDelModelElementModal(true));
  };

  const previewHandler = async () => {
    const { id: elementId } = props as Record<string, string>;

    if (modelCode && service) {
      await dispatch(fetchGetModelElementPreviewAction({ modelCode, elementId }));
    }
  };

  const hasPreviewButton = (code: string): boolean => {
    switch (code) {
      case 'promo':
      case 'content-pages':
      case 'ref-brend':
        return true;
      default:
        return false;
    }
  };

  return (
    <Group
      position={'right'}
      sx={{
        flexWrap: 'nowrap',
      }}
    >
      {modelCode && hasPreviewButton(modelCode) && (
        <ActionIcon
          name="Предварительный просмотр"
          title="Предварительный просмотр"
          onClick={previewHandler}
          disabled={fetchingModelElement}
        >
          <IconEye size={20} color="gray" />
        </ActionIcon>
      )}
      <ActionIcon name="Изменить" title="Изменить" onClick={changeHandler}>
        <IconPencil size={20} color="gray" />
      </ActionIcon>

      <ActionIcon name="Удалить" title="Удалить" onClick={() => deleteHandler()}>
        <IconTrash size={20} color="gray" />
      </ActionIcon>
    </Group>
  );
};

export default ModelTableButtons;
