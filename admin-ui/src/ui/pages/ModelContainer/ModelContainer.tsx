import { ModelExportStatusEnum } from '@/types';

import { FC, useEffect, useMemo, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import { Box, Button, Group, Pagination } from '@mantine/core';
import { Flex } from '@mantine/core';
import { useLocalStorage } from '@mantine/hooks';

import { useFilters } from '@/hooks/useFilters';
import { useURLPagination } from '@/hooks/useUrlPagination';

import FiltersBuilder from '@/ui/organisms/FiltersBuilder/FiltersBuilder';
import SelectedCounter from '@/ui/organisms/SelectedCounter/SelectedCounter';
import ShowElements from '@/ui/organisms/ShowElements/ShowElements';
import TableExt from '@/ui/organisms/TableExt/TableExt';
import PageBody from '@/ui/templates/Page/components/PageBody/PageBody';
import PageFooter from '@/ui/templates/Page/components/PageFooter/PageFooter';
import PageHeader from '@/ui/templates/Page/components/PageHeader/PageHeader';
import PageLoader from '@/ui/templates/Page/components/PageLoader/PageLoader';
import Page from '@/ui/templates/Page/Page';

import ModelTableButtons from './components/ModelTableButtons/ModelTableButtons';
import ModelTableModals from './components/ModelTableModals/ModelTableModals';
import { generateElements } from './utils/generateElements';
import { getSortableKeys } from './utils/getSortableKeys';
import { ModelContext } from './utils/modelContext';

import { AppDispatch } from '@/store';
import {
  fetchDelModelElementsAction,
  fetchExportModel,
  fetchGetExportModel,
  fetchGetModelAction,
  fetchGetModelElementsAction,
  fetchGetModelSettingsAction,
  fetchModelElementFieldsAction,
  selectFetchingGetModelElements,
  selectModel,
  selectModelElements,
  selectModelElementsTotal,
  selectModelExport,
  selectModelSettingsFilterable,
  selectModelSettingsShownInList,
  selectModelSettingsSortable,
  selectSelectedModelElements,
  setModelElements,
  setModelSettingsFilterable,
  setOpenNewModelElementModal,
  setSelectedModelElements,
} from '@/store/slices/models/model';
import { selectServiceChanged } from '@/store/slices/service/service';

const ModelContainer: FC = () => {
  const dispatch: AppDispatch = useDispatch();
  const { modelCode } = useParams<{ modelCode: string }>();
  const [modelExportLoading, setModelExportLoading] = useState<boolean>(false);
  const model = useSelector(selectModel);
  const modelSettingsFilterable = useSelector(selectModelSettingsFilterable);
  const modelSettingsShowInList = useSelector(selectModelSettingsShownInList);
  const modelSettingsSortable = useSelector(selectModelSettingsSortable);
  const fetchingModelElements = useSelector(selectFetchingGetModelElements);
  const modelElements = useSelector(selectModelElements);
  const modelElementsTotal = useSelector(selectModelElementsTotal);
  const selectedModelElements = useSelector(selectSelectedModelElements);
  const serviceChanged = useSelector(selectServiceChanged);
  const modelExport = useSelector(selectModelExport);
  const { filters, onFiltersChange } = useFilters();
  const { currentPage, setPage, pagesCount, currentOffset, currentLimit, setLimit } =
    useURLPagination(modelElementsTotal);

  const [service] = useLocalStorage({ key: 'service' });
  const mappedFilters = useMemo(
    () =>
      Object.keys(filters).map((key) => ({
        code: key,
        values: filters[key] instanceof Array ? filters[key] : [filters[key]?.toString()],
      })),
    [filters]
  );

  const showModelName = useMemo(
    () => !fetchingModelElements && model?.name?.length,
    [fetchingModelElements, model]
  );

  const params = useMemo(
    () => ({
      limit: currentLimit,
      offset: currentOffset,
    }),
    [currentLimit, currentOffset]
  );

  const reloadHandler = () => {
    if (!modelCode) return;
    dispatch(
      fetchGetModelElementsAction({
        modelCode,
        params,
        data: { filter: { fields: mappedFilters } },
      })
    );
  };

  useEffect(() => {
    document.body.style.overflow = 'hidden';
    return () => {
      document.body.style.overflow = 'initial';
      dispatch(setModelSettingsFilterable(null));
      dispatch(setModelElements(null));
    };
  }, []);

  useEffect(() => {
    reloadHandler();
  }, [filters, modelCode]);

  useEffect(() => {
    if (modelCode && service && !serviceChanged) {
      dispatch(fetchGetModelAction({ code: modelCode }));
      dispatch(fetchGetModelSettingsAction({ code: modelCode }));
      dispatch(fetchGetModelElementsAction({ modelCode, params }));
    }
  }, [modelCode, currentLimit, currentOffset, service]);

  const breadcrumbs = [
    {
      name: 'Модели',
      url: '/models',
    },
    {
      name: `Элементы модели${showModelName ? `: ${model?.name}` : ''}`,
    },
  ];

  const showSelectedCounter = () => {
    if (selectedModelElements && selectedModelElements.length > 0) return true;

    return false;
  };

  const delElementsHandler = async () => {
    if (modelCode && selectedModelElements && service) {
      await dispatch(
        fetchDelModelElementsAction({
          modelCode,
          data: { ids: selectedModelElements.map((el) => el.id) },
        })
      );
      await dispatch(fetchGetModelElementsAction({ modelCode, params }));
    }
  };

  const newModalElementHandler = () => {
    dispatch(setOpenNewModelElementModal(true));
    if (modelCode && service) dispatch(fetchModelElementFieldsAction({ modelCode }));
  };

  const handleExportModel = (code?: string) => {
    if (!modelExport && code) {
      dispatch(fetchExportModel(code)).then(() => {
        setModelExportLoading(true);
        setTimeout(() => {
          dispatch(fetchGetExportModel(code)).finally(() => setModelExportLoading(false));
        }, 1000);
      });
    } else if (modelExport && code) {
      if (modelExport.status !== ModelExportStatusEnum.PENDING) {
        dispatch(fetchExportModel(code)).then(() => {
          setModelExportLoading(true);
          setTimeout(() => {
            dispatch(fetchGetExportModel(code)).finally(() => setModelExportLoading(false));
          }, 1000);
        });
      } else {
        dispatch(fetchGetExportModel(code));
      }
    }
  };

  const getRightButton = (code?: string) => {
    switch (code) {
      case 'subscriptions':
      case 'partnership-requests':
      case 'category-requests':
        return (
          <Button onClick={() => handleExportModel(code)} loading={modelExportLoading}>
            Сохранить файл
          </Button>
        );
      default:
        return <Button onClick={newModalElementHandler}>Новый элемент</Button>;
    }
  };

  return (
    <Page>
      <ModelContext.Provider value={reloadHandler}>
        <PageHeader
          title={`Элементы модели${showModelName ? `: ${model?.name}` : ''}`}
          backLink="/models"
          breadcrumbs={breadcrumbs}
          rightButton={getRightButton(modelCode)}
        />

        <PageBody>
          <Flex align="flex-end" justify="space-between" mb={16}>
            <Flex direction="column" align="stretch">
              {/* <SearchInput searchAction={setQuery} /> - went to backlog */}
              <FiltersBuilder
                loading={false}
                filtersConfig={modelSettingsFilterable || []}
                onFiltersChange={onFiltersChange}
              />
            </Flex>
            <Box>
              <ShowElements defaultValue={params.limit} changeCallback={setLimit} />
            </Box>
          </Flex>

          {(!modelElements || modelElements.length === 0 || fetchingModelElements) && (
            <PageLoader
              loading={fetchingModelElements}
              zIndex={100}
              text="У модели пока нет элементов"
            />
          )}
          {modelElements && modelElements.length > 0 && modelSettingsShowInList && (
            <Box h={0} sx={{ flex: '1 0 0' }}>
              <TableExt
                buttons={ModelTableButtons}
                config={modelSettingsShowInList}
                rows={generateElements(modelElements, modelSettingsShowInList)}
                selectable
                selectCallback={(values) => dispatch(setSelectedModelElements(values))}
                sortableKeys={getSortableKeys(modelSettingsSortable)}
              />
            </Box>
          )}

          <PageFooter>
            <Group position="apart" grow>
              {showSelectedCounter() && (
                <SelectedCounter
                  count={selectedModelElements && selectedModelElements.length}
                  buttonText="Удалить"
                  callback={delElementsHandler}
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
        </PageBody>

        <ModelTableModals />
      </ModelContext.Provider>
    </Page>
  );
};

export default ModelContainer;
