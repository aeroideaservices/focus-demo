import { TModelField } from '@/types';

import { FC, useContext } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { Modal, ModalProps, Text } from '@mantine/core';

import { LoaderOverlay } from '@/ui/organisms/LoaderOverlay/LoaderOverlay';

import { ModelContext } from '../../utils/modelContext';
import ModelFormBuilder from '../ModelFormBuilder/ModelFormBuilder';

import { AppDispatch } from '@/store';
import {
  fetchAddModelElementAction,
  fetchChangeModelElementAction,
  selectCurrentModelElement,
  selectFetchingGetModelElementFields,
  selectModelElementFields,
} from '@/store/slices/models/model';
import { selectCurrentService } from '@/store/slices/service/service';

interface IModelElementModal extends ModalProps {
  title: string;
  type: 'new' | 'edit';
}

const ModelElementModal: FC<IModelElementModal> = ({ title, type, ...props }) => {
  const dispatch: AppDispatch = useDispatch();
  const urlParams = useParams();
  const modelCode = urlParams.modelCode;
  const fetchingModelElementFields = useSelector(selectFetchingGetModelElementFields);
  const modelElementFields = useSelector(selectModelElementFields);
  const service = useSelector(selectCurrentService);
  const currentElement = useSelector(selectCurrentModelElement);
  const reloadCallback = useContext(ModelContext);

  const submitHandler = async (values: Record<string, unknown>) => {
    if (modelCode && service && type === 'new') {
      await dispatch(
        fetchAddModelElementAction({
          modelCode,
          data: { fieldValues: values.fieldValues as TModelField[] },
        })
      );
      reloadCallback();
    } else if (modelCode && service && type === 'edit' && currentElement?.id) {
      await dispatch(
        fetchChangeModelElementAction({
          modelCode,
          elementId: currentElement.id,
          data: { fieldValues: values.fieldValues },
        })
      );
      reloadCallback();
    }
  };

  return (
    <Modal
      centered
      size={765}
      {...props}
      title={
        <Text fz={22} fw={700}>
          {title}
        </Text>
      }
    >
      <LoaderOverlay visible={fetchingModelElementFields} />
      {modelElementFields && modelElementFields.length > 0 ? (
        <ModelFormBuilder options={modelElementFields} onSubmit={submitHandler} type={type} />
      ) : (
        <Text align="center">Опций не найдено</Text>
      )}
    </Modal>
  );
};

export default ModelElementModal;
