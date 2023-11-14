import { TMailsTemplate } from '@/types';

import { FC, useMemo, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { Button, Checkbox, Table } from '@mantine/core';
import { IconPencil, IconTrash } from '@tabler/icons-react';

import { PLUGIN_PATHS, PluginCode } from '@/constants/plugins';
import { useURLPagination } from '@/hooks/useUrlPagination';

import ModalConfirm from '@/ui/organisms/ModalConfirm/ModalConfirm';

import { AppDispatch } from '@/store';
import {
  fetchDelMailsTemplateAction,
  fetchMailsTemplatesAction,
  selectDelMailsTemplateModal,
  selectDelMailsTemplatesModal,
  selectMailsTemplatesTotal,
  setOpenDelMailsTemplateModal,
  setOpenDelMailsTemplatesModal,
} from '@/store/slices/mailsTemplates/mailsTemplates';

interface IConfigurationsTable {
  elements: TMailsTemplate[];
  query: string;
  arrItemsId: string[];
  setArrItemsId: (value: string[]) => void;
  multiDelConfirmHandler: () => void;
}

const MailsTemplatesTable: FC<IConfigurationsTable> = ({
  elements,
  query,
  arrItemsId,
  setArrItemsId,
  multiDelConfirmHandler,
}) => {
  const dispatch: AppDispatch = useDispatch();
  const navigate = useNavigate();

  const delDelMailsTemplateModal = useSelector(selectDelMailsTemplateModal);
  const delDelMailsTemplatesModal = useSelector(selectDelMailsTemplatesModal);
  const mailsTemplatesTotal = useSelector(selectMailsTemplatesTotal);

  const { currentLimit, currentOffset } = useURLPagination(mailsTemplatesTotal || 0);

  const [currentItemId, setCurrentItemId] = useState<null | string>(null);
  const rootUrl = PLUGIN_PATHS[PluginCode.MAIL_TEMPLATES];

  const params = useMemo(
    () => ({
      limit: currentLimit,
      offset: currentOffset,
    }),
    [currentLimit, currentOffset]
  );

  const delHandler = (id: string) => {
    setCurrentItemId(id);
    dispatch(setOpenDelMailsTemplateModal(true));
  };

  const delConfirmHandler = async (id: null | string) => {
    if (id !== null) await dispatch(fetchDelMailsTemplateAction(id));
    await dispatch(
      fetchMailsTemplatesAction({
        ...params,
        query,
        order: 'asc',
      })
    );
  };

  const pushDelArr = (id: string) => {
    const arr = [...arrItemsId];
    if (!arr.includes(id)) {
      arr.push(id);
      setArrItemsId(arr);
    } else {
      setArrItemsId(arr.filter((item) => item !== id));
    }
  };

  const pushAllDel = () => {
    const arr: string[] = [];
    if (elements.length === arrItemsId.length && arrItemsId.length !== 0) {
      setArrItemsId([]);
    } else {
      elements.forEach((item) => arr.push(item.id));
      setArrItemsId(arr);
    }
  };

  const subString35 = (str: string) => {
    if (str && str.length > 35) {
      return str.substring(0, 35) + '...';
    }
    return str;
  };

  const confirmHandler = () => {
    dispatch(setOpenDelMailsTemplatesModal(false));
    dispatch(setOpenDelMailsTemplateModal(false));

    if (delDelMailsTemplatesModal) multiDelConfirmHandler();
    else delConfirmHandler(currentItemId);
  };

  const ths = (
    <tr>
      <th>
        <Checkbox
          onChange={pushAllDel}
          checked={elements.length === arrItemsId.length && arrItemsId.length !== 0}
          indeterminate={
            elements.length > 0 && elements.length !== arrItemsId.length && arrItemsId.length !== 0
          }
        />
      </th>
      <th>Тема</th>
      <th>Отправитель</th>
      <th>Получатель</th>
      <th></th>
    </tr>
  );
  const rows = elements.map((element) => (
    <tr key={element.id}>
      <td>
        <Checkbox
          checked={arrItemsId.includes(element.id)}
          onChange={() => pushDelArr(element.id)}
        />
      </td>
      <td style={{ maxWidth: '254px' }}>{subString35(element.subject)}</td>
      <td style={{ maxWidth: '254px' }}>{subString35(element.sender)}</td>
      <td style={{ maxWidth: '254px' }}>{subString35(element.recipients.join(', '))}</td>
      <td style={{ textAlign: 'right' }}>
        <Button
          name="Изменить"
          title="Изменить"
          variant="subtle"
          color="gray"
          compact
          onClick={() => navigate(`${rootUrl}/${element.id}`)}
        >
          <IconPencil size={20} />
        </Button>
        <Button
          name="Удалить"
          title="Удалить"
          variant="subtle"
          color="gray"
          compact
          onClick={() => delHandler(element.id as string)}
        >
          <IconTrash size={20} />
        </Button>
      </td>
    </tr>
  ));

  return (
    <>
      <Table highlightOnHover verticalSpacing="sm" fontSize="md">
        <thead style={{ background: '#E8ECF0' }}>{ths}</thead>
        <tbody>{rows}</tbody>
      </Table>

      <ModalConfirm
        title="Вы уверены?"
        text="Восстановить данные после удаления не получится"
        opened={delDelMailsTemplateModal || delDelMailsTemplatesModal}
        onClose={() =>
          delDelMailsTemplatesModal
            ? dispatch(setOpenDelMailsTemplatesModal(false))
            : dispatch(setOpenDelMailsTemplateModal(false))
        }
        confirmHandler={confirmHandler}
      />
    </>
  );
};

export default MailsTemplatesTable;
