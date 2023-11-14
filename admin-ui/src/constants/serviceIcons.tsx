import { IServiceIcons } from '@/types';

import {
  IconArticle,
  IconAtom,
  IconBook,
  IconBox,
  IconCircle,
  IconCurrencyRubel,
  IconFileExport,
  IconHomeDollar,
  IconMapPin,
  IconMessageCircle,
  IconUserPlus,
  IconUsers,
} from '@tabler/icons-react';

export const SERVICE_ICONS: IServiceIcons = {
  geo: <IconMapPin />,
  demo: <IconAtom />,
  integrations: <IconBox />,
  catalog: <IconBook />,
  clients: <IconUsers />,
  'go-clients': <IconUserPlus />,
  content: <IconArticle />,
  reviews: <IconMessageCircle />,
  sale: <IconCurrencyRubel />,
  seller: <IconHomeDollar />,
  export: <IconFileExport />,
  default: <IconCircle />,
};
