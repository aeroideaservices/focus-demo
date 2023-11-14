import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router-dom';

import { PluginCode } from '@/constants/plugins';

import { AppDispatch } from '@/store';
import { selectCurrentPlugin, setCurrentPlugin } from '@/store/slices/service/service';

export const usePluginNavigation = () => {
  const dispatch: AppDispatch = useDispatch();
  const currentPlugin = useSelector(selectCurrentPlugin);
  const { plugin } = useParams<{ plugin: PluginCode }>();

  const setPlugin = (newPlugin: PluginCode) => dispatch(setCurrentPlugin(newPlugin));

  useEffect(() => {
    if (plugin) setPlugin(plugin);
  }, [plugin]);

  return {
    currentPlugin,
    setCurrentPlugin: setPlugin,
  };
};
