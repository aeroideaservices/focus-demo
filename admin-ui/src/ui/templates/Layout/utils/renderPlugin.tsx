import { PluginCode } from '@/constants/plugins';

import {
  ConfsPage,
  MailsPage,
  MediaPage,
  MenusPage,
  ModelPage,
  ModelPageV2,
  ReviewsPage,
} from './pluginPages';

import RequireAuth from '@/services/RequireAuth/RequireAuth';

const pluginPagesMap: { [key in PluginCode]: JSX.Element } = {
  [PluginCode.MODELS]: ModelPage,
  [PluginCode.MODELS_V2]: ModelPageV2,
  [PluginCode.MEDIA]: MediaPage,
  [PluginCode.MENUS]: MenusPage,
  [PluginCode.CONFIGURATIONS]: ConfsPage,
  [PluginCode.MAIL_TEMPLATES]: MailsPage,
  [PluginCode.REVIEWS]: ReviewsPage,
};

export const renderPlugin = (plugin: PluginCode) => (
  <RequireAuth>{pluginPagesMap[plugin]}</RequireAuth>
);
