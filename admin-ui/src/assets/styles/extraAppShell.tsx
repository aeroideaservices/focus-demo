import { MantineTheme } from '@mantine/core';

export const extraAppShell = {
  AppShell: {
    styles: (theme: MantineTheme) => ({
      root: { backgroundColor: theme.colors.gray[1] },
    }),
  },
};
