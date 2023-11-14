import { TModelElement } from '@/types';

import { URLS } from '@/api/urls';

import apiInstance from '@/utils/apiInstance';

import { LIMIT } from '@/constants/common';
import { ServiceCode } from '@/constants/services';

const SERVICE_TO_SEARCH = ServiceCode.CATALOG;
const MODEL_TO_SEARCH = 'product';

const getFieldValue = (product: TModelElement, fieldCode: string) =>
  product.fieldValues.find((field) => field.code === fieldCode)?.value || '';

const mapToSelectItem = (product: TModelElement) => ({
  label: getFieldValue(product, 'name'),
  leftTag: getFieldValue(product, 'external_id'),
  value: `${getFieldValue(product, 'external_id')}?${getFieldValue(product, 'id')}`,
});

export const searchProduct = async (query: string) => {
  const products = await apiInstance.get<{ items: TModelElement[] }>(
    URLS.models_v2.modelElements.getModelElementsList(MODEL_TO_SEARCH),
    {
      params: {
        query,
        fields: ['id', 'name', 'external_id'],
        offset: 0,
        limit: LIMIT,
      },
      headers: {
        ['service-code']: SERVICE_TO_SEARCH,
      },
    }
  );
  return products.data.items.map(mapToSelectItem);
};

export const getProduct = async (productId: string) => {
  const product = await apiInstance.get<TModelElement>(
    URLS.models_v2.modelElement.getModelElement(MODEL_TO_SEARCH, productId),
    {
      headers: {
        ['service-code']: SERVICE_TO_SEARCH,
      },
    }
  );

  return mapToSelectItem(product.data);
};
