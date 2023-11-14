import { FC, useEffect, useMemo, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { Box, Button, Group, Pagination, ScrollArea } from '@mantine/core';

import { PLUGIN_PATHS, PluginCode } from '@/constants/plugins';
import { useURLPagination } from '@/hooks/useUrlPagination';

import SearchInput from '@/ui/organisms/SearchInput/SearchInput';
import SelectedCounter from '@/ui/organisms/SelectedCounter/SelectedCounter';
import ShowElements from '@/ui/organisms/ShowElements/ShowElements';
import PageBody from '@/ui/templates/Page/components/PageBody/PageBody';
import PageFooter from '@/ui/templates/Page/components/PageFooter/PageFooter';
import PageHeader from '@/ui/templates/Page/components/PageHeader/PageHeader';
import PageLoader from '@/ui/templates/Page/components/PageLoader/PageLoader';
import Page from '@/ui/templates/Page/Page';

import MailsTemplatesTable from './components/MailsTemplatesTable/MailsTemplatesTable';

import { AppDispatch } from '@/store';
import {
  fetchMailsTemplatesAction,
  fetchMultiDelMailsTemplateAction,
  selectFetchingMailsTemplatesStatus,
  selectMailsTemplatesItems,
  selectMailsTemplatesTotal,
} from '@/store/slices/mailsTemplates/mailsTemplates';

const MailsTemplatesContainer: FC = () => {
  const dispatch: AppDispatch = useDispatch();
  const navigate = useNavigate();
  const mailsTemplatesItems = useSelector(selectMailsTemplatesItems);
  const mailsTemplatesTotal = useSelector(selectMailsTemplatesTotal);
  const mailsTemplatesFetch = useSelector(selectFetchingMailsTemplatesStatus);
  const [query, setQuery] = useState('');
  const [arrItemsId, setArrItemsId] = useState<string[]>([]);
  const rootUrl = PLUGIN_PATHS[PluginCode.MAIL_TEMPLATES];
  const { currentLimit, currentOffset, currentPage, pagesCount, setLimit, setPage } =
    useURLPagination(mailsTemplatesTotal || 0);

  const params = useMemo(
    () => ({
      limit: currentLimit,
      offset: currentOffset,
    }),
    [currentLimit, currentOffset]
  );

  const getMailTemplates = () =>
    dispatch(
      fetchMailsTemplatesAction({
        ...params,
        order: 'asc',
        query,
      })
    );

  useEffect(() => {
    getMailTemplates();
  }, [currentLimit, currentOffset, query]);

  const multiDelConfirmHandler = async () => {
    if (arrItemsId?.length > 0) await dispatch(fetchMultiDelMailsTemplateAction(arrItemsId));
    setArrItemsId([]);
    getMailTemplates();
  };

  return (
    <Page>
      <PageHeader
        title="Почтовые шаблоны"
        rightButton={<Button onClick={() => navigate(`${rootUrl}/new`)}>Новый шаблон</Button>}
      />
      <PageBody>
        <Group mb={24} position="apart" grow>
          <SearchInput searchAction={setQuery} placeholder="Начните вводить ID или тему" />
          <ShowElements defaultValue={params.limit} changeCallback={setLimit} />
        </Group>

        {(!mailsTemplatesItems || mailsTemplatesItems?.length === 0 || mailsTemplatesFetch) && (
          <PageLoader
            zIndex={100}
            loading={mailsTemplatesFetch}
            text="У вас нет почтовых шаблонов"
          />
        )}

        {mailsTemplatesItems && mailsTemplatesItems?.length > 0 && (
          <>
            <Box h={0} sx={{ flex: '1 0 0' }}>
              <ScrollArea h="100%" pb={12} pr={12}>
                <MailsTemplatesTable
                  elements={mailsTemplatesItems}
                  query={query}
                  arrItemsId={arrItemsId}
                  setArrItemsId={setArrItemsId}
                  multiDelConfirmHandler={multiDelConfirmHandler}
                />
              </ScrollArea>
            </Box>

            <PageFooter>
              <Group position="apart" grow>
                {arrItemsId?.length > 0 && (
                  <SelectedCounter
                    count={arrItemsId.length}
                    buttonText="Удалить"
                    callback={multiDelConfirmHandler}
                  />
                )}
                {pagesCount > 1 && (
                  <Pagination
                    position={'right'}
                    value={currentPage}
                    total={pagesCount}
                    onChange={setPage}
                  />
                )}
              </Group>
            </PageFooter>
          </>
        )}
      </PageBody>
    </Page>
  );
};

export default MailsTemplatesContainer;
