import { IReviewFormFields } from '@/types/reviews/reviews';

export const transformReviewFormValues = (values: IReviewFormFields): IReviewFormFields => {
  const result: IReviewFormFields = {
    ...values,
    response: values.response !== '' ? values.response : null,
    text: values.text !== '' ? values.text : null,
  };

  return result;
};
