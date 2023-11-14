export type TMailsTemplate = {
  id: string;
  recipients: string[];
  sender: string;
  subject: string;
  template: string;
};

export type TMailForm = Omit<TMailsTemplate, 'recipients'> & {
  recipients: string;
};

export type TGetTMailsTemplate = {
  items: TMailsTemplate[];
  total: number;
};
