import { TModel, ViewTypeEnum } from '@/types';

import { FC } from 'react';
import InputMask from 'react-input-mask';
import { useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';
import {
  Box,
  Button,
  Checkbox,
  Group,
  Input,
  NumberInput,
  Textarea,
  TextInput,
  Title,
} from '@mantine/core';
import { DateTimePicker } from '@mantine/dates';
import { useForm } from '@mantine/form';

import EditorJSComponent from '@/ui/organisms/EditorJSComponent/EditorJSComponent';
import { FileInput } from '@/ui/organisms/FileInput/FileInput';
import SearchableSelect from '@/ui/organisms/SearchableSelect/SearchableSelect';
import stringToSearchableData from '@/ui/organisms/SearchableSelect/utils/stringToSearchableData';
import stringToSearchableValues from '@/ui/organisms/SearchableSelect/utils/stringToSearchableValues';
import SearchableSelectDnD from '@/ui/organisms/SearchableSelectDnD/SearchableSelectDnD';
import TextEditor from '@/ui/organisms/TextEditor/TextEditor';

import 'dayjs/locale/ru';

import { getFormatedModelFormData } from '../../utils/getFormatedFormData';
import { getInitialValuesModelForm, TField } from '../../utils/getInitialValuesModelForm';
import FiasInputs from '../ModelElementModal/FiasInputs';

import { addTransliteration } from './utils/addTransliteration';
import { getSluggableObjects } from './utils/getSluggableObjects';
import { validationFields } from './utils/validationFields';

import { selectModelElementValues } from '@/store/slices/models/model';

interface IModelFormBuilder {
  options: TModel[];
  onSubmit: (values: Record<string, unknown>) => void;
  type: string;
}

const ModelFormBuilder: FC<IModelFormBuilder> = ({ options, onSubmit, type }) => {
  const { modelCode } = useParams<{ modelCode: string }>();
  const modelElementValues = useSelector(selectModelElementValues);

  const form = useForm({
    initialValues: {
      fields: getInitialValuesModelForm(
        type,
        options,
        type !== 'new' ? modelElementValues?.fieldValues : undefined
      ),
    },
    validate: {
      fields: {
        value: (value, array, path) => validationFields(value, array, path, type),
      },
    },
  });

  // Собираем массив объектов с полями и их зависимостями
  const sluggableObjects = getSluggableObjects(form.values.fields);

  const fields = form.values.fields.map((item, index) => {
    return (
      <Box key={item.key}>
        {item.block && (
          <Title order={4} mb={24}>
            {form.values.fields[index - 1].block !== item.block ? item.block : null}
          </Title>
        )}

        {item.type === ViewTypeEnum.STRING && (
          <TextInput
            mb={24}
            label={item.label}
            placeholder={item.label}
            required={item.required}
            disabled={type === 'new' ? false : item.disabled}
            error="test"
            onInput={addTransliteration(item, sluggableObjects, form, type)}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {item.type === ViewTypeEnum.PHONE && (
          <Input.Wrapper
            mb={24}
            label={item.label}
            required={item.required}
            error={form.errors[`fields.${index}.value`]}
          >
            <Input
              component={InputMask}
              mask={'+7 999 999-99-99'}
              placeholder={item.label}
              required={item.required}
              disabled={item.disabled}
              autoComplete="off"
              {...form.getInputProps(`fields.${index}.value`)}
            />
          </Input.Wrapper>
        )}

        {item.type === ViewTypeEnum.CHECKBOX && (
          <Checkbox
            mb={24}
            label={item.label}
            required={item.required}
            disabled={item.disabled}
            {...form.getInputProps(`fields.${index}.checked`, { type: 'checkbox' })}
          />
        )}

        {item.type === ViewTypeEnum.DATETIME && (
          <DateTimePicker
            mb={24}
            label={item.label}
            required={item.required}
            placeholder={item.label}
            locale="ru"
            valueFormat="DD.MM.YYYY HH:mm"
            popoverProps={{ withinPortal: true }}
            error={form.getInputProps(`fields.${index}.value`).error}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {item.type === ViewTypeEnum.MEDIA && (
          <Box mb={24}>
            <FileInput
              label={item.label}
              required={item.required}
              {...form.getInputProps(`fields.${index}.value`)}
            />
          </Box>
        )}

        {(item.type === ViewTypeEnum.NUMERIC || item.type === ViewTypeEnum.INT) && (
          <NumberInput
            mb={24}
            label={item.label}
            placeholder={item.label}
            required={item.required}
            disabled={item.disabled}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {item.type === ViewTypeEnum.FLOAT && (
          <NumberInput
            mb={24}
            label={item.label}
            step={0.1}
            precision={6}
            min={0}
            max={1000}
            placeholder={item.label}
            required={item.required}
            disabled={item.disabled}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {item.type === ViewTypeEnum.TEXT && (
          <Textarea
            mb={24}
            minRows={4}
            autosize
            label={item.label}
            required={item.required}
            maxLength={item.code === 'summary' && modelCode === 'ref-brend' ? 170 : undefined}
            error={form.getInputProps(`fields.${index}.value`).error}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {item.type === ViewTypeEnum.HTML &&
          item.formField &&
          item.formField.code === 'editor_js' && (
            <EditorJSComponent
              mb={24}
              label={item.label}
              name={item.name}
              required={item.required}
              error={form.errors[`fields.${index}.value`]}
              useForm={form}
              formField={item.formField}
              fieldName={`fields.${index}.value`}
            />
          )}

        {item.type === ViewTypeEnum.HTML && !item.formField && (
          <TextEditor
            label={item.label}
            required={item.required}
            error={form.getInputProps(`fields.${index}.value`).error}
            content={item.value}
            onChange={(value) => form.setFieldValue(`fields.${index}.value`, value)}
          />
        )}

        {item.type === ViewTypeEnum.KEYVALUES && (
          <FiasInputs
            label={item.label}
            placeholder={item.label}
            disabled={item.disabled ? true : false}
            required={item.required ? true : false}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {(item.type === ViewTypeEnum.SLICEOFSTRINGS || item.type === ViewTypeEnum.SLICEOFUUID) && (
          <SearchableSelect
            mb={24}
            label={item.label}
            placeholder={item.label}
            required={item.required}
            disabled={item.disabled}
            formField={item.formField}
            data={item.value ? stringToSearchableData(item.value) : []}
            defaultValue={item.value ? stringToSearchableValues(item.value) : undefined}
            inputProps={form.getInputProps(`fields.${index}.value`)}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {item.type === ViewTypeEnum.MODEL && (
          <TextInput
            required={item.required}
            mb={24}
            label={item.label}
            disabled={item.disabled}
            placeholder={item.label}
            {...form.getInputProps(`fields.${index}.value`)}
            onChange={(e) => {
              form
                .getInputProps(`fields.${index}.value`)
                .onChange(e.target.value ? e.target.value : '');
            }}
          />
        )}

        {item.type === ViewTypeEnum.EMAIL && (
          <TextInput
            mb={24}
            label={item.label}
            placeholder={item.label}
            required={item.required}
            disabled={item.code === 'id' || item.disabled}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}

        {item.type === ViewTypeEnum.MODELSCOLLECTION && (
          <SearchableSelectDnD
            label={item.label}
            required={item.required}
            disabled={item.disabled}
            formField={item.formField}
            inputProps={form.getInputProps(`fields.${index}.value`)}
            {...form.getInputProps(`fields.${index}.value`)}
          />
        )}
      </Box>
    );
  });

  const submitHandler = (values: TField[]) => {
    onSubmit(getFormatedModelFormData(values));
  };

  return (
    <form onSubmit={form.onSubmit((values) => submitHandler([...values.fields]))} noValidate>
      {fields}

      <Group position="right">
        <Button type="submit">Сохранить</Button>
      </Group>
    </form>
  );
};

export default ModelFormBuilder;
