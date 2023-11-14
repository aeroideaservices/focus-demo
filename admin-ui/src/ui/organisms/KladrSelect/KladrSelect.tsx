import { FC, memo, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { MultiSelect } from '@mantine/core';
import { debounce } from 'lodash';

import { AppDispatch } from '@/store';
import {
  fetchModelSearch,
  selectModalSearch,
  setChosenData,
  setSearchData,
} from '@/store/slices/models/model';

interface IKladrSelect {
  formField: any;
  formData: any;
  index: number;
  label: string;
  type: string;
  required?: boolean;
  service?: string | null;
}

const KladrSelect: FC<IKladrSelect> = memo(
  ({ formField, formData, index, label, type, required }) => {
    const dispatch: AppDispatch = useDispatch();
    const modalSearch = useSelector(selectModalSearch);

    useEffect(() => {
      return () => {
        const temp = { ...modalSearch };
        delete temp[index];
        dispatch(setSearchData({ ...temp }));
      };
    }, []);

    const handleSearch = async (value: string) => {
      const fetchOpts = {
        uri: formField.opts.request.uri,
        body: formField.opts.request.body,
        meth: formField.opts.request.meth,
        type: type,
        index,
      };

      if (value.length >= 3) {
        dispatch(fetchModelSearch({ ...fetchOpts, value }));
      } else {
        dispatch(setSearchData([]));
      }
    };

    return (
      <MultiSelect
        mb={24}
        data={modalSearch[index] ? modalSearch[index] : []}
        label={label}
        placeholder={formData.value ? formData.value : label}
        onSearchChange={debounce(handleSearch, 500)}
        searchable
        error={formData.error}
        required={required}
        onChange={(value) => {
          dispatch(setChosenData({ value, index, type }));
          formData.onChange(value);
        }}
        value={typeof formData.value === 'string' ? formData.value.split(',') : formData.value}
      />
    );
  }
);

export default KladrSelect;
