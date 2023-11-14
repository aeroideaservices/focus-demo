import { FC } from 'react';
import { Box, useMantineTheme } from '@mantine/core';
import { IconFile } from '@tabler/icons-react';

const FileInputFilePreview: FC = () => {
  const { colors } = useMantineTheme();
  return (
    <Box ml="25%" mr="25%">
      <IconFile color={colors.gray[5]} size="100%" />
    </Box>
  );
};

export default FileInputFilePreview;
