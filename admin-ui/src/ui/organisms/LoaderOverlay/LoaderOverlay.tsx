import { FC } from 'react';
import { LoadingOverlay, LoadingOverlayProps } from '@mantine/core';

export const LoaderOverlay: FC<LoadingOverlayProps> = ({ ...props }) => (
  <LoadingOverlay
    {...props}
    overlayColor="#FFFFFF"
    overlayOpacity={1}
    loader={
      <img
        src="/images/loader.gif"
        style={{ minWidth: 0, minHeight: 0, maxHeight: '80%', maxWidth: '80%' }}
      />
    }
  />
);
