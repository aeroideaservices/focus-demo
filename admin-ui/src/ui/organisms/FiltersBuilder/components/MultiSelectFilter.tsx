import { createContext, FC, memo, useContext } from 'react';
import { createStyles, MultiSelect, MultiSelectValueProps, Text } from '@mantine/core';

import { isString } from '@/utils/isString';

import { FilterTypes, SelectItem, TFilterProps } from '../types';
import { useActiveFilters } from '../utils/useActiveFilters';

const useStyles = createStyles(() => ({
  values: {
    width: 'min-content',
  },
  searchInput: {
    minWidth: '20%',
    width: 'auto !important',
  },
}));

const optionAll = { label: 'Все', value: '' };

const MultiSelectContext = createContext<{
  data: (string | SelectItem)[];
  values: (string | SelectItem)[];
}>({ data: [], values: [] });

const CustomValueComponent = ({ value, label }: MultiSelectValueProps & { value: string }) => {
  const { values } = useContext(MultiSelectContext);
  const itemIndex = values.findIndex((item) =>
    typeof item === 'string' ? item === value : item.value === value
  );

  if (itemIndex !== 0) return null;
  if (values.length > 1) return <Text opacity={0.7}>Выбрано: {values.length}</Text>;
  else
    return (
      <Text maw="80px" truncate>
        {label || value}
      </Text>
    );
};

export const MultiSelectFilter: FC<TFilterProps<FilterTypes.IFilterMultiSelect>> = memo(
  ({
    initialValue = [],
    code,
    data,
    name,
    placeholder = 'Выберите варианты',
    showOptionAll = false,
    value = initialValue,
    inputProps,
  }) => {
    const { onChange } = useActiveFilters(code, initialValue);
    const displayData = showOptionAll && value.length < data.length ? [optionAll, ...data] : data;
    const { classes } = useStyles();
    const changeHandler = (values: string[]) => {
      if (values.includes(optionAll.value)) {
        const filteredValues = data
          .filter((v) => (isString(v) ? v !== optionAll.value : v.value === optionAll.value))
          .map((item) => (isString(item) ? item : item.value));
        onChange(filteredValues);
      } else onChange(values);
    };

    return (
      <MultiSelectContext.Provider value={{ data: displayData, values: value }}>
        <MultiSelect
          clearable
          withinPortal
          label={name}
          onChange={changeHandler}
          classNames={classes}
          valueComponent={CustomValueComponent}
          {...inputProps}
          {...{ data: displayData, placeholder, value: value || initialValue }}
        />
      </MultiSelectContext.Provider>
    );
  }
);
