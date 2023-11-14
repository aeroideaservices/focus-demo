import { FC } from 'react';
import { Box, useMantineTheme } from '@mantine/core';
import { IconFolder } from '@tabler/icons-react';

const FileInputFolderPreview: FC = () => {
  const { colors } = useMantineTheme();
  return (
    <Box ml="25%" mr="25%">
      <IconFolder color={colors.gray[5]} size="100%" />
    </Box>
  );
};

export default FileInputFolderPreview;
