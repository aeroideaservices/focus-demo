import { FilterViewTypeEnum } from '@/types';

import { FC, useEffect, useMemo, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useSearchParams } from 'react-router-dom';
import { Box, Button, Flex, Pagination } from '@mantine/core';

import { LIMIT } from '@/constants/common';
import { REVIEW_STATUS_ITEMS, REVIEWS_SEARCH_PLACEHOLDER } from '@/constants/reviews';
import { TABLE_REVIEWS, TABLE_REVIEWS_SORTABLE_COLUMNS } from '@/constants/tableHeaders';
import { useFilters } from '@/hooks/useFilters';
import { useServices } from '@/hooks/useServices';
import { useURLPagination } from '@/hooks/useUrlPagination';

import FiltersBuilder from '@/ui/organisms/FiltersBuilder/FiltersBuilder';
import { TFiltersConfig } from '@/ui/organisms/FiltersBuilder/types';
import SearchInput from '@/ui/organisms/SearchInput/SearchInput';
import ShowElements from '@/ui/organisms/ShowElements/ShowElements';
import TableExt from '@/ui/organisms/TableExt/TableExt';
import PageBody from '@/ui/templates/Page/components/PageBody/PageBody';
import PageFooter from '@/ui/templates/Page/components/PageFooter/PageFooter';
import PageHeader from '@/ui/templates/Page/components/PageHeader/PageHeader';
import PageLoader from '@/ui/templates/Page/components/PageLoader/PageLoader';
import Page from '@/ui/templates/Page/Page';

import ReviewsTableButtons from './components/ReviewsTableButtons/ReviewsTableButtons';
import ReviewsTableModals from './components/ReviewsTableModals/ReviewsTableModals';
import { getDisplayReviews } from './utils/getDisplayReviews';

import { AppDispatch } from '@/store';
import { selectFetchingGetModels } from '@/store/slices/models/models';
import {
  fetchReviewsAction,
  selectReviews,
  selectReviewsTotal,
  setOpenAddReviewsElementModal,
} from '@/store/slices/reviews/reviews';

const filtersConfig: TFiltersConfig = [
  {
    code: 'status',
    name: 'Статус',
    viewType: FilterViewTypeEnum.MULTISELECT,
    data: REVIEW_STATUS_ITEMS,
    showOptionAll: true,
    inputProps: {
      searchable: true,
    },
  },
  {
    code: 'rating',
    name: 'Оценка',
    viewType: FilterViewTypeEnum.MULTISELECT,
    data: ['1', '2', '3', '4', '5'],
    showOptionAll: true,
  },
  {
    code: 'editingDate',
    name: 'Дата изменения',
    viewType: FilterViewTypeEnum.DATE_RANGE,
    inputProps: { maxDate: new Date() },
  },
];

const ReviewsContainer: FC = () => {
  const dispatch: AppDispatch = useDispatch();
  const [searchParams] = useSearchParams();
  const { currentService } = useServices();
  const [query, setQuery] = useState('');
  const { filters, onFiltersChange } = useFilters({
    rating: (value: string[]) => value.map((item) => Number(item)),
    editingDate: (value) => ({
      from: value[0] || undefined,
      to: value[1] || undefined,
    }),
  });

  const fetchingModels = useSelector(selectFetchingGetModels);
  const reviews = useSelector(selectReviews);
  const reviewsTotal = useSelector(selectReviewsTotal);
  const { currentLimit, currentOffset, currentPage, pagesCount, setLimit, setPage } =
    useURLPagination(reviewsTotal);

  const showReviews = useMemo(() => reviews.length > 0, [reviews]);

  const displayReviews = useMemo(() => getDisplayReviews(reviews), [reviews]);

  useEffect(() => {
    dispatch(
      fetchReviewsAction({
        params: {
          limit: currentLimit,
          offset: currentOffset,
          query,
        },
        data: { filter: filters },
      })
    );
  }, [query, filters, searchParams, currentService]);

  useEffect(() => {
    setPage(1);
  }, [filters]);

  return (
    <Page>
      <PageHeader
        title="Отзывы"
        rightButton={
          <Button
            onClick={() => {
              dispatch(setOpenAddReviewsElementModal(true));
            }}
          >
            Новый отзыв
          </Button>
        }
      />

      <PageBody>
        <Box w="50%" mb={10}>
          <SearchInput searchAction={setQuery} placeholder={REVIEWS_SEARCH_PLACEHOLDER} />
        </Box>

        <Flex align="flex-start" justify="space-between" mb={24} gap={15}>
          <Flex align="stretch" w={'100%'}>
            <FiltersBuilder
              loading={false}
              filtersConfig={filtersConfig}
              onFiltersChange={onFiltersChange}
            />
          </Flex>
          <ShowElements pt={23} defaultValue={LIMIT} changeCallback={setLimit} />
        </Flex>

        {!showReviews && <PageLoader loading={fetchingModels} text="У вас пока нет отзывов" />}

        {showReviews && (
          <Box h={0} sx={{ flex: '1 0 0' }}>
            <TableExt
              config={TABLE_REVIEWS}
              rows={displayReviews}
              sortableKeys={TABLE_REVIEWS_SORTABLE_COLUMNS}
              buttons={ReviewsTableButtons}
            />
          </Box>
        )}

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
      </PageBody>

      <ReviewsTableModals />
    </Page>
  );
};

export default ReviewsContainer;
