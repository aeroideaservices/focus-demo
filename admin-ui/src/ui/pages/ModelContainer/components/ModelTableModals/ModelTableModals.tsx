import { FC } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams, useSearchParams } from 'react-router-dom';

import { getLimitInURL } from '@/utils/getLimitInURL';
import { getOffsetInURL } from '@/utils/getOffsetInURL';

import ModalConfirm from '@/ui/organisms/ModalConfirm/ModalConfirm';

import ModelElementModal from '../ModelElementModal/ModelElementModal';

import { AppDispatch } from '@/store';
import {
  fetchDelModelElementAction,
  fetchGetModelElementsAction,
  selectCurrentModelElement,
  selectDelModelElementModal,
  selectEditModelElementModal,
  selectNewModelElementModal,
  setOpenDelModelElementModal,
  setOpenEditModelElementModal,
  setOpenNewModelElementModal,
} from '@/store/slices/models/model';
import { selectCurrentService } from '@/store/slices/service/service';

const ModelTableModals: FC = () => {
  const dispatch: AppDispatch = useDispatch();
  const params = useParams();
  const [searchParams] = useSearchParams();
  const currentModelElement = useSelector(selectCurrentModelElement);
  const delModelElementModal = useSelector(selectDelModelElementModal);
  const newModelElementModel = useSelector(selectNewModelElementModal);
  const editModelElementModel = useSelector(selectEditModelElementModal);
  const service = useSelector(selectCurrentService);

  const delConfirmHandler = async () => {
    const { modelCode } = params;
    const elementId = currentModelElement?.id;

    if (modelCode && elementId && service) {
      await dispatch(fetchDelModelElementAction({ modelCode, elementId }));
      await dispatch(
        fetchGetModelElementsAction({
          modelCode,
          params: {
            offset: getOffsetInURL(searchParams),
            limit: getLimitInURL(searchParams),
          },
        })
      );
    }
  };

  return (
    <>
      <ModalConfirm
        title="Вы уверены?"
        text="Восстановить данные после удаления не получится"
        opened={delModelElementModal}
        onClose={() => dispatch(setOpenDelModelElementModal(false))}
        confirmHandler={() => delConfirmHandler()}
      />

      <ModelElementModal
        type="new"
        title="Новый элемент"
        opened={newModelElementModel}
        onClose={() => dispatch(setOpenNewModelElementModal(false))}
      />

      <ModelElementModal
        type="edit"
        title="Изменить элемент"
        opened={editModelElementModel}
        onClose={() => dispatch(setOpenEditModelElementModal(false))}
      />
    </>
  );
};

export default ModelTableModals;
