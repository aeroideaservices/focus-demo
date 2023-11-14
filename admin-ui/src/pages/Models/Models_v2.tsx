import { FC } from 'react';
import { Route, Routes } from 'react-router-dom';
import { useDocumentTitle } from '@mantine/hooks';

import { TITLE_MODELS } from '@/constants/titles';

import ModelContainerV2 from '@/ui/pages/ModelContainer_v2/ModelContainer';
import ModelsContainerV2 from '@/ui/pages/ModelsContainer_v2/ModelsContainer';

const ModelsV2: FC = () => {
  useDocumentTitle(TITLE_MODELS);

  return (
    <Routes>
      <Route index element={<ModelsContainerV2 />} />
      <Route path="/:modelCode" element={<ModelContainerV2 />} />
    </Routes>
  );
};

export default ModelsV2;
