import { HTTPMethodEnum } from '@/types';
import { FormFieldTypeEnum, TFormField } from '@/types/models_v2/models_v2';
import { IReview, IReviewFormFields } from '@/types/reviews/reviews';

import { useMemo } from 'react';
import { ChangeEvent, FC } from 'react';
import { useSelector } from 'react-redux';
import { Button, Group, Select, Textarea, TextInput } from '@mantine/core';
import { DateTimePicker } from '@mantine/dates';
import { FormErrors, useForm, yupResolver } from '@mantine/form';
import { IconSearch } from '@tabler/icons-react';

import { getCookie } from '@/utils/cookie';

import { LIMIT, OFFSET } from '@/constants/common';
import { REVIEW_STATUS_ITEMS, ReviewStatus } from '@/constants/reviews';
import { ServiceCode } from '@/constants/services';
import { REVIEW_FORM } from '@/constants/validationSchemas';
import { withInitialThunk } from '@/hocs/withInitialThunk';

import { FileInput } from '@/ui/organisms/FileInput/FileInput';
import RatingInput from '@/ui/organisms/RatingInput/RatingInput';
import SearchableSelectV2 from '@/ui/organisms/SearchableSelectV2/SearchableSelectV2';

import { getInitialValuesReviewForm } from '../../utils/getInitialValuesReviewForm';
import { transformReviewFormValues } from '../../utils/transformReviewFormValues';

import {
  fetchInactivationOptions,
  selectInactivationOptions,
} from '@/store/slices/reviews/reviews';

interface IReviewFormBuilder {
  onSubmit: (values: IReviewFormFields) => void;
  reviewsItem?: IReview;
  type?: 'new' | 'edit';
}

const ReviewFormBuilder: FC<IReviewFormBuilder> = ({ reviewsItem, onSubmit }) => {
  const token = JSON.parse(getCookie('token') as string);
  const inactivationOptions = useSelector(selectInactivationOptions);
  const isEdit = useMemo(() => Boolean(reviewsItem), [reviewsItem]);

  const form = useForm({
    validate: yupResolver(REVIEW_FORM),
    initialValues: getInitialValuesReviewForm(token, inactivationOptions, reviewsItem),
  });

  const responseChangeHandler = ({
    currentTarget: { value },
  }: ChangeEvent<HTMLTextAreaElement>) => {
    const currentValue = form.getInputProps('responseDate').value;

    form.setFieldValue('response', value);

    if (!currentValue) {
      form.setFieldValue('responseDate', new Date());
    } else if (!value) {
      form.setFieldValue('responseDate', null);
    }
  };

  const statusChangeHandler = (value: ReviewStatus) => {
    const newActivationDate = value === ReviewStatus.ACTIVE ? new Date() : null;

    form.setFieldValue('status', value);
    form.setFieldValue('activationDate', newActivationDate);
  };

  const currentStatus = form.getInputProps('status').value;
  const statusData =
    currentStatus === ReviewStatus.WAIT
      ? REVIEW_STATUS_ITEMS.map((item) =>
          item.value === ReviewStatus.WAIT ? { ...item, disabled: true } : item
        )
      : REVIEW_STATUS_ITEMS.filter((item) => item.value !== ReviewStatus.WAIT);

  const submitHandler = (values: IReviewFormFields) => {
    onSubmit(transformReviewFormValues(values));
  };

  const onError = (errors: FormErrors) => {
    const errorsArray = Object.keys(errors);
    if (errorsArray.length) {
      const firstErrorElement: HTMLElement | null = document.getElementById(errorsArray[0]);

      if (firstErrorElement) {
        firstErrorElement.scrollIntoView({ behavior: `smooth`, block: 'center' });
      }
    }
  };

  // TODO небольшой костыль пока бекенд не приведет
  // сервис отзывов к структуре моделей v2
  const articleField: TFormField = {
    code: 'productId',
    name: 'productId',
    type: FormFieldTypeEnum.SELECT,
    value: form.getInputProps('productId').value,
    extra: {
      display: ['name', 'externalId'],
      identifier: 'id',
      request: {
        body: {
          fields: ['externalId', 'name'],
        },
        meth: HTTPMethodEnum.POST,
        paginated: true,
        uri: '/models-v2/product/elements/list',
        service: ServiceCode.CATALOG,
      },
    },
  };

  return inactivationOptions.length ? (
    <form onSubmit={form.onSubmit(submitHandler, onError)} noValidate>
      <Group mb={24} position="apart" grow align="flex-start">
        <DateTimePicker
          id={'createdDate'}
          label={'Дата создания'}
          required
          disabled={isEdit}
          placeholder={'Дата создания'}
          locale="ru"
          valueFormat="DD.MM.YYYY HH:mm"
          {...form.getInputProps(`createdDate`)}
        />
        <DateTimePicker
          id={'editingDate'}
          label={'Дата изменения'}
          required
          disabled
          placeholder={'Дата изменения'}
          locale="ru"
          valueFormat="DD.MM.YYYY HH:mm"
          {...form.getInputProps(`editingDate`)}
        />
      </Group>

      <SearchableSelectV2
        id={`productId`}
        mb={24}
        icon={<IconSearch size="1.1rem" />}
        label={'Артикул товара'}
        placeholder={'Введите название или артикул товара'}
        field={articleField}
        required
        customSelect
        getSelectedData={(data) => {
          if (data.length > 0) {
            form.setFieldValue('productExternalId', data[0].code ? Number(data[0].code) : null);
          }
        }}
        {...form.getInputProps('productId')}
      />

      <RatingInput
        id={`rating`}
        mb={24}
        label={'Оценка'}
        required
        ratingProps={{ ...form.getInputProps(`rating`), fractions: 1, size: 'lg' }}
      />

      <Textarea
        id={'text'}
        mb={24}
        minRows={4}
        autosize
        placeholder="Отзыв"
        label="Отзыв"
        {...form.getInputProps('text')}
      />

      <FileInput
        id={'files'}
        mb={24}
        serviceCode={ServiceCode.REVIEWS}
        maxFiles={5}
        multiple
        {...form.getInputProps(`files`)}
      />

      <TextInput
        id={'usefulness'}
        mb={24}
        label="Полезность"
        placeholder="Полезность"
        disabled={true}
        {...form.getInputProps('usefulness')}
      />

      <Group mb={24} position="apart" grow align="flex-start">
        <TextInput
          id={'userName'}
          label="Имя покупателя"
          placeholder="Имя покупателя"
          required
          {...form.getInputProps('userName')}
        />

        <TextInput
          id={'userId'}
          label="ID покупателя"
          placeholder="ID покупателя"
          disabled={true}
          {...form.getInputProps('userId')}
        />
      </Group>

      <Select
        id={'status'}
        mb={24}
        label="Статус"
        placeholder="Выберите вариант"
        required
        data={statusData}
        {...form.getInputProps('status')}
        onChange={statusChangeHandler}
      />

      {currentStatus === ReviewStatus.INACTIVE && (
        <Select
          id={'inactivationReasonId'}
          mb={24}
          data={inactivationOptions}
          label="Причина отклонения отзыва"
          placeholder="Не выбранно"
          required={currentStatus === ReviewStatus.INACTIVE}
          {...form.getInputProps('inactivationReasonId')}
        />
      )}

      <Textarea
        id={'response'}
        mb={24}
        autosize
        minRows={4}
        placeholder="Ответ"
        label="Ответ"
        required={Boolean(form.getInputProps('responseDate').value)}
        {...form.getInputProps('response')}
        onChange={responseChangeHandler}
      />

      <Group mb={24} position="apart" grow>
        <DateTimePicker
          id={'responseDate'}
          label={'Дата ответа'}
          required={Boolean(form.getInputProps('response').value)}
          placeholder={'Дата ответа'}
          locale="ru"
          valueFormat="DD.MM.YYYY HH:mm"
          {...form.getInputProps(`responseDate`)}
        />
        <DateTimePicker
          id={'activationDate'}
          label={'Дата активации'}
          disabled
          placeholder={'Дата активации'}
          locale="ru"
          valueFormat="DD.MM.YYYY HH:mm"
          {...form.getInputProps(`activationDate`)}
        />
      </Group>

      <TextInput
        id={'moderatorId'}
        mb={24}
        label="Модератор"
        placeholder="ID модератора"
        required
        disabled
        {...form.getInputProps('moderatorId')}
      />

      <Group position="right">
        <Button type="submit">Подтвердить</Button>
      </Group>
    </form>
  ) : null;
};

export default withInitialThunk(
  ReviewFormBuilder,
  fetchInactivationOptions({ limit: LIMIT, offset: OFFSET })
);
