import { TMailForm, TMailsTemplate } from '@/types';

import { FC, useEffect, useState } from 'react';
import { useSelector } from 'react-redux';
import { Navigate, useNavigate, useParams } from 'react-router-dom';
import {
  Box,
  Button,
  CSSObject,
  MantineTheme,
  Text,
  TextInput,
  TextInputStylesNames,
} from '@mantine/core';
import { useForm, yupResolver } from '@mantine/form';
import { isEmpty } from 'lodash';

import { PLUGIN_PATHS, PluginCode } from '@/constants/plugins';
import { EMAIL_FORM } from '@/constants/validationSchemas';
import { useServices } from '@/hooks/useServices';

import TextEditor from '@/ui/organisms/TextEditor/TextEditor';
import PageBody from '@/ui/templates/Page/components/PageBody/PageBody';
import PageHeader from '@/ui/templates/Page/components/PageHeader/PageHeader';
import PageLoader from '@/ui/templates/Page/components/PageLoader/PageLoader';
import Page from '@/ui/templates/Page/Page';

import {
  addMailTemplateAction,
  fetchMailTemplateAction,
  putMailTemplateAction,
} from '@/store/slices/mailsTemplates/mailsTemplates';
import { selectServiceChanged } from '@/store/slices/service/service';

const InputStyles: (theme: MantineTheme) => Partial<Record<TextInputStylesNames, CSSObject>> = (
  theme
) => ({
  root: {
    display: 'grid',
    gridTemplateColumns: 'auto minmax(128px, 528px)',
    gridTemplateAreas: `'label input' 'empty error'`,
  },
  label: {
    display: 'flex',
    flexGrow: 1,
    fontWeight: 600,
    gridArea: 'label',
  },
  wrapper: {
    gridArea: 'input',
  },
  error: {
    gridArea: 'error',
  },
  invalid: {
    ['::placeholder']: {
      color: theme.colors.red[3],
    },
  },
});

const MailContainer: FC = () => {
  const { id: templateId } = useParams();
  const navigate = useNavigate();
  const isNewTemplate = templateId && templateId === 'new';
  const serviceChanged = useSelector(selectServiceChanged);
  const rootUrl = PLUGIN_PATHS[PluginCode.MAIL_TEMPLATES];

  const { availablePlugins } = useServices();

  const [loading, setLoading] = useState(false);

  const form = useForm<Partial<TMailForm>>({
    initialValues: {
      sender: '',
      recipients: '',
      subject: '',
      template: '',
    },
    validate: yupResolver(EMAIL_FORM),
  });

  useEffect(() => {
    if (templateId && !isNewTemplate) {
      fetchMailTemplateAction(templateId).then((data) => {
        if (data) {
          form.setValues({ ...data, recipients: data.recipients.join(', ') });
        }
      });
    }
  }, []);

  const handleFormSubmit = (values: Partial<TMailForm>) => {
    setLoading(true);
    const mappedValues: Partial<TMailsTemplate> = {
      ...values,
      recipients: values.recipients?.split(/,\s?/).filter((el) => el !== '') || [],
    };

    if (templateId && !isNewTemplate) {
      putMailTemplateAction(templateId, mappedValues).then((res) => {
        setLoading(false);

        if (res !== null) navigate(rootUrl);
      });
    } else {
      addMailTemplateAction(mappedValues).then((res) => {
        setLoading(false);

        if (res !== null) navigate(rootUrl);
      });
    }
  };

  if (templateId && !isNewTemplate && Object.values(form.values).every((value) => value === '')) {
    return null;
  }

  const breadcrumbs = [
    {
      name: 'Почтовые шаблоны',
      url: '/mail-templates',
    },
    {
      name: isNewTemplate ? 'Новый шаблон' : 'Изменение шаблона',
    },
  ];

  return (
    <Page>
      <PageHeader
        title={isNewTemplate ? 'Новый шаблон' : 'Изменение шаблона:'}
        subTitle={!isNewTemplate ? `ID ${templateId}` : ''}
        backLink={rootUrl}
        breadcrumbs={breadcrumbs}
        rightButton={
          <Button type={'submit'} form={'newMailTemplateForm'}>
            Сохранить
          </Button>
        }
      />
      <PageBody>
        {serviceChanged && (
          <Navigate
            to={`/${
              isEmpty(availablePlugins) ? '' : availablePlugins[availablePlugins.length - 1]
            }`}
          />
        )}

        {loading ? (
          <PageLoader zIndex={100} loading={loading} text="" />
        ) : (
          <>
            <form
              onSubmit={form.onSubmit(handleFormSubmit)}
              style={{ maxWidth: 760, marginBottom: 44 }}
              id={'newMailTemplateForm'}
              noValidate
            >
              <TextInput
                mb={24}
                styles={InputStyles}
                required
                label="От кого"
                placeholder="Укажите email или переменную"
                {...form.getInputProps('sender')}
              />
              <TextInput
                mb={24}
                styles={InputStyles}
                required
                label="Кому"
                placeholder="Укажите email или переменные через запятую"
                {...form.getInputProps('recipients')}
              />
              <TextInput
                mb={24}
                styles={InputStyles}
                required
                label="Тема письма"
                placeholder="Укажите тему письма"
                {...form.getInputProps('subject')}
              />
              <TextEditor
                mih={150}
                required
                styles={InputStyles}
                label="Шаблон письма"
                error={form.getInputProps('template').error}
                content={form.getInputProps('template').value}
                onChange={(value) => form.setFieldValue('template', value)}
              />
            </form>

            <Box maw={760} display={'flex'}>
              <Text
                fw={600}
                align={'left'}
                sx={{
                  flexGrow: 1,
                }}
              >
                Доступные переменные
              </Text>
              <Box
                maw={528}
                display={'flex'}
                w={'100%'}
                sx={{
                  flexDirection: 'column',
                }}
              >
                <Text align={'left'}>#AUTHOR# - Автор сообщения</Text>
                <Text align={'left'}>#AUTHOR_EMAIL# - Email автора сообщения</Text>
                <Text align={'left'}>#SITE_NAME# - Название сайта</Text>
                <Text align={'left'}>#SERVER_NAME# - URL сервера</Text>
              </Box>
            </Box>
          </>
        )}
      </PageBody>
    </Page>
  );
};

export default MailContainer;
