import { ReactNode } from 'react';
import {
  IconAdjustmentsHorizontal,
  IconGridDots,
  IconHierarchy2,
  IconMail,
  IconMessageCircle,
  IconPlayerPlay,
} from '@tabler/icons-react';

export enum PluginCode {
  MODELS = 'models',
  MODELS_V2 = 'models-v2',
  MEDIA = 'media',
  MENUS = 'menus',
  CONFIGURATIONS = 'configurations',
  MAIL_TEMPLATES = 'mail-templates',
  REVIEWS = 'reviews',
}

export const PLUGIN_NAMES: { [key in PluginCode]: string } = {
  [PluginCode.MODELS]: 'Модели',
  [PluginCode.MODELS_V2]: 'Модели',
  [PluginCode.MEDIA]: 'Медиа',
  [PluginCode.MENUS]: 'Меню',
  [PluginCode.CONFIGURATIONS]: 'Конфигурации',
  [PluginCode.MAIL_TEMPLATES]: 'Почтовые шаблоны',
  [PluginCode.REVIEWS]: 'Отзывы',
};

export const PLUGIN_PATHS: { [key in PluginCode]: string } = {
  [PluginCode.MODELS]: '/models',
  [PluginCode.MODELS_V2]: '/models-v2',
  [PluginCode.MEDIA]: '/media',
  [PluginCode.MENUS]: '/menus',
  [PluginCode.CONFIGURATIONS]: '/configurations',
  [PluginCode.MAIL_TEMPLATES]: '/mail-templates',
  [PluginCode.REVIEWS]: '/reviews',
};

export const PLUGIN_ICONS: { [key in PluginCode]: ReactNode } = {
  [PluginCode.MODELS]: <IconHierarchy2 size={24} />,
  [PluginCode.MODELS_V2]: <IconHierarchy2 size={24} />,
  [PluginCode.MEDIA]: <IconPlayerPlay size={24} />,
  [PluginCode.MENUS]: <IconGridDots size={24} />,
  [PluginCode.CONFIGURATIONS]: <IconAdjustmentsHorizontal size={24} />,
  [PluginCode.MAIL_TEMPLATES]: <IconMail size={24} />,
  [PluginCode.REVIEWS]: <IconMessageCircle size={24} />,
};

export const PLUGINS_ORDER: PluginCode[] = [
  PluginCode.MODELS,
  PluginCode.MODELS_V2,
  PluginCode.MEDIA,
  PluginCode.MENUS,
  PluginCode.CONFIGURATIONS,
  PluginCode.REVIEWS,
  PluginCode.MAIL_TEMPLATES,
];
