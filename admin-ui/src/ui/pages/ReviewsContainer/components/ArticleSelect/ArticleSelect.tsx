import { FC, forwardRef, PropsWithChildren, useEffect, useMemo, useRef, useState } from 'react';
import {
  Box,
  CSSObject,
  LoadingOverlay,
  Select,
  SelectProps,
  Text,
  TextProps,
  useMantineTheme,
} from '@mantine/core';
import { debounce } from 'lodash';

import { SelectItem } from '@/ui/organisms/FiltersBuilder/types';

type TArticleSelectItem = SelectItem & {
  leftTag?: string;
  rightTag?: string;
};

const loadingItem = { value: 'loading', label: 'Загрузка...' };

const TagText = forwardRef<HTMLDivElement, PropsWithChildren<TextProps>>(
  ({ children, ...props }, ref) => {
    const { colors } = useMantineTheme();

    return (
      <Text
        {...props}
        sx={{ whiteSpace: 'nowrap', fontSize: '14px' }}
        c={colors['jungle-mist'][3]}
        px="sm"
        ref={ref}
      >
        {children}
      </Text>
    );
  }
);

const SearchSelectItem = forwardRef<HTMLDivElement, TArticleSelectItem>(
  ({ label, leftTag, rightTag, ...others }, ref) => (
    <Box ref={ref} {...others} display="table-row" pos="relative">
      <TagText display="table-cell">{leftTag}</TagText>
      <Text display="table-cell" py={8}>
        {label}
      </Text>
      <TagText display="table-cell">{rightTag}</TagText>
    </Box>
  )
);

type TArticleSelectState<M extends boolean = false> = Omit<SelectProps, 'data'> & {
  value: string;
  onChange: M extends true ? (values: string[]) => void : (value: string) => void;
  searchRequest: (query: string) => Promise<TArticleSelectItem[]>;
  itemRequest?: (value: string) => Promise<TArticleSelectItem>;
};

export const ArticleSelect: FC<TArticleSelectState> = ({
  value,
  searchRequest,
  itemRequest,
  onChange,
  ...props
}) => {
  const [staticItem, setStaticItem] = useState<TArticleSelectItem | undefined>();
  const [searchResult, setSearchresult] = useState<TArticleSelectItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [paddings, setPaddings] = useState<CSSObject>({});
  const [searchString, setSearchString] = useState('');
  const leftTagRef = useRef<HTMLDivElement>(null);
  const rightTagRef = useRef<HTMLDivElement>(null);
  const selectRef = useRef<HTMLInputElement>(null);

  const load = async function <R>(promise: Promise<R>) {
    setLoading(true);
    try {
      const result = await promise;
      setLoading(false);
      return result;
    } catch {
      setLoading(false);
      return null;
    }
  };

  const handleValueChange = async (newValue: string) => {
    if (!newValue || newValue === staticItem?.value) return;
    setSearchString(newValue);
    let item: SelectItem | null | undefined;
    const itemFromSearchResult = searchResult.find((result) => result.value === newValue);
    if (itemFromSearchResult) item = itemFromSearchResult;
    else if (itemRequest) {
      item = await load(itemRequest(newValue));
    } else {
      const items = await load(searchRequest(newValue));
      item = items?.find((option) => option.value === newValue);
    }

    if (item) {
      setStaticItem(item);
      onChange(item.value);
    }
  };

  const loadSuggestions = useMemo(
    () =>
      debounce(async (queryString: string) => {
        const result = await load(searchRequest(queryString));
        if (result) {
          setSearchresult(result);
        }
      }, 500),
    []
  );

  const handleSearch = async (queryString: string) => {
    setSearchString(queryString);
    if (!queryString || queryString === staticItem?.label) return;
    loadSuggestions(queryString);
  };

  const currentData: SelectItem[] = useMemo(() => {
    if (loading) return [];
    if (searchResult.length) return searchResult;
    if (staticItem) return [staticItem];
    return [];
  }, [loading, searchResult, staticItem]);

  useEffect(() => {
    if (value) handleValueChange(value);
  }, []);

  useEffect(() => {
    const newPaddings: CSSObject = {};

    if (staticItem?.leftTag && leftTagRef.current)
      newPaddings.paddingLeft = `${leftTagRef.current?.clientWidth}px !important`;
    if (staticItem?.rightTag && rightTagRef.current)
      newPaddings.paddingRight = `${rightTagRef.current.clientWidth}px !important`;
    setPaddings(newPaddings);
  }, [searchString]);

  const showLeftTag = useMemo(
    () => staticItem?.leftTag && searchString === staticItem?.label,
    [staticItem, searchString]
  );
  const showRightTag = useMemo(
    () => staticItem?.rightTag && searchString === staticItem?.label,
    [staticItem, searchString]
  );

  const filterItemsFn = (search: string, item: TArticleSelectItem) =>
    item.value === loadingItem.value ||
    [item.label, item.leftTag, item.rightTag].some((str) =>
      str?.toLowerCase().includes(search.toLocaleLowerCase())
    );

  return (
    <Box pos="relative">
      <Select
        {...props}
        data={currentData}
        searchable
        onSearchChange={handleSearch}
        searchValue={searchString}
        {...{ value }}
        onChange={handleValueChange}
        icon={showLeftTag && <TagText ref={leftTagRef}>{staticItem?.leftTag}</TagText>}
        rightSection={showRightTag && <TagText ref={rightTagRef}>{staticItem?.rightTag}</TagText>}
        itemComponent={SearchSelectItem}
        selectOnBlur={false}
        styles={{
          itemsWrapper: { display: 'table !important' },
          input: paddings,
          icon: { width: 'auto !important' },
        }}
        filter={filterItemsFn}
        ref={selectRef}
      />
      <LoadingOverlay visible={loading} />
    </Box>
  );
};
