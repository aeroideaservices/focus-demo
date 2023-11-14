import { FC } from 'react';
import { Route, Routes } from 'react-router-dom';

import MailContainer from '@/ui/pages/MailContainer/MailContainer';
import MailsTemplatesContainer from '@/ui/pages/MailsTemplatesContainer/MailsTemplatesContainer';

const Mails: FC = () => {
  return (
    <Routes>
      <Route index element={<MailsTemplatesContainer />} />
      <Route path=":id" element={<MailContainer />} />
    </Routes>
  );
};

export default Mails;
