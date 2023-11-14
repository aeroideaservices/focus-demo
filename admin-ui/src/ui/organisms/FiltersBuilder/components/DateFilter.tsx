import { FC, memo } from 'react';
import { DatePicker } from '@mantine/dates';

import { FilterTypes, TFilterProps } from '../types';
import { useActiveFilters } from '../utils/useActiveFilters';

export const DateFilter: FC<TFilterProps<FilterTypes.IFilterDate>> = memo(
  ({
    code,
    // name,
    initialValue = null,
    value = initialValue,
    placeholder = 'Укажите период',
    inputProps,
  }) => {
    const { onChange } = useActiveFilters(code, initialValue);

    const changeHandler = (newValue: Date) => {
      onChange(newValue.toISOString());
    };

    return (
      <DatePicker
        // label={name}
        {...inputProps}
        {...{ placeholder }}
        value={value ? new Date(value) : null}
        onChange={changeHandler}
      />
    );
  }
);
