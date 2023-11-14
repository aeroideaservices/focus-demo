import { FC, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Box, Group, Pagination } from '@mantine/core';

import { TABLE_MODELS } from '@/constants/tableHeaders';
import { useServices } from '@/hooks/useServices';
import { useURLPagination } from '@/hooks/useUrlPagination';

import ShowElements from '@/ui/organisms/ShowElements/ShowElements';
import TableExt from '@/ui/organisms/TableExt/TableExt';
import PageBody from '@/ui/templates/Page/components/PageBody/PageBody';
import PageFooter from '@/ui/templates/Page/components/PageFooter/PageFooter';
import PageHeader from '@/ui/templates/Page/components/PageHeader/PageHeader';
import PageLoader from '@/ui/templates/Page/components/PageLoader/PageLoader';
import Page from '@/ui/templates/Page/Page';

import ModelsTableButtons from './components/ModelsTableButtons/ModelsTableButtons';

import { AppDispatch } from '@/store';
import {
  fetchGetModelsAction,
  selectFetchingGetModels,
  selectModels,
  selectModelsTotal,
} from '@/store/slices/models/models';

const ModelsContainer: FC = () => {
  const dispatch: AppDispatch = useDispatch();

  const fetchingModels = useSelector(selectFetchingGetModels);
  const models = useSelector(selectModels);
  const modelsTotal = useSelector(selectModelsTotal);
  const { currentService } = useServices();
  const { currentLimit, currentOffset, currentPage, pagesCount, setLimit, setPage } =
    useURLPagination(modelsTotal);

  useEffect(() => {
    dispatch(fetchGetModelsAction({ params: { limit: currentLimit, offset: currentOffset } }));
  }, [currentLimit, currentOffset, currentService]);

  return (
    <Page>
      <PageHeader title="Модели" />

      <PageBody>
        <>
          {(!models || models.length === 0 || fetchingModels) && (
            <PageLoader zIndex={100} loading={fetchingModels} text="У вас пока нет моделей" />
          )}

          {models && models.length > 0 && (
            <>
              <Group mb={24} position="right" grow>
                <ShowElements defaultValue={currentLimit} changeCallback={setLimit} />
              </Group>

              <Box h={0} sx={{ flex: '1 0 0' }}>
                <TableExt config={TABLE_MODELS} rows={models} buttons={ModelsTableButtons} />
              </Box>

              <PageFooter>
                {pagesCount > 1 && (
                  <Pagination
                    position={'right'}
                    value={currentPage}
                    total={pagesCount}
                    onChange={setPage}
                  />
                )}
              </PageFooter>
            </>
          )}
        </>
      </PageBody>
    </Page>
  );
};

export default ModelsContainer;
