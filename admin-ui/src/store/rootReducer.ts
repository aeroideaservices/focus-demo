// ROOT REDUCER EXAMPLE

// 1. Import your reducers from entities

// import cartReducer from './entities/cart/reducers';

import { combineReducers } from 'redux';

import authReducer from '@/store/slices/auth/auth';
import configurationReducer from '@/store/slices/configuration/configuration';
import configurationOptionReducer from '@/store/slices/configuration/configurationOption';
import configurationOptionsReducer from '@/store/slices/configuration/configurationOptions';
import configurationsReducer from '@/store/slices/configuration/configurations';
import mailsTemplatesReducer from '@/store/slices/mailsTemplates/mailsTemplates';
import mediaReducer from '@/store/slices/media/media';
import mediaFilesReducer from '@/store/slices/media/mediaFiles';
import mediaFoldersReducer from '@/store/slices/media/mediaFolders';
import menuReducer from '@/store/slices/menu/menu';
import menuItems from '@/store/slices/menu/menuItems';
import menusReducer from '@/store/slices/menu/menus';
import modelReducer from '@/store/slices/models/model';
import modelsReducer from '@/store/slices/models/models';
import modelReducer_v2 from '@/store/slices/models_v2/model';
import modelsReducer_v2 from '@/store/slices/models_v2/models';
import reviewsReducer from '@/store/slices/reviews/reviews';
import serviceReducer from '@/store/slices/service/service';

// 2. Define reducers into common object
const rootReducer = combineReducers({
  configurations: configurationsReducer,
  configuration: configurationReducer,
  configurationOptions: configurationOptionsReducer,
  configurationOption: configurationOptionReducer,
  mailsTemplates: mailsTemplatesReducer,
  media: mediaReducer,
  mediaFiles: mediaFilesReducer,
  mediaFolders: mediaFoldersReducer,
  models: modelsReducer,
  model_v2: modelReducer_v2,
  models_v2: modelsReducer_v2,
  model: modelReducer,
  service: serviceReducer,
  menu: menuReducer,
  menus: menusReducer,
  menuItems: menuItems,
  auth: authReducer,
  reviews: reviewsReducer,
});

export default rootReducer;
export type IRootReducer = ReturnType<typeof rootReducer>;
