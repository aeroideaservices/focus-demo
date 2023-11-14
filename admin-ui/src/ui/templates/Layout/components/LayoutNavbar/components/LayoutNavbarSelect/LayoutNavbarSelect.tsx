import { FC, useState } from 'react';
import { Box, CloseButton, createStyles, Flex, Menu, Text } from '@mantine/core';
import { IconSettings } from '@tabler/icons-react';

import { SERVICE_ICONS } from '@/constants/serviceIcons';
import { ServiceCode } from '@/constants/services';
import { useServices } from '@/hooks/useServices';

import LayoutNavbarButton from '../LayoutNavbarButton/LayoutNavbarButton';

interface IService {
  code: ServiceCode;
  name: string;
}

const useStyles = createStyles((theme) => ({
  item: {
    transition: 'color 0.25s ease',
    ['svg']: {
      color: theme.colors['jungle-mist'][4],
    },

    ['&:hover']: {
      color: theme.colors['science-blue'][9],
      ['svg']: {
        color: theme.colors['science-blue'][9],
      },
    },
  },
}));

const LayoutNavbarSelect: FC = () => {
  const { classes } = useStyles();
  const [showMenu, setShowMenu] = useState<boolean>(false);
  const { services, currentService, setCurrentService } = useServices();

  const isCurrentItem = (item: IService) => item.code === currentService?.code;

  return (
    <Menu opened={showMenu} onChange={setShowMenu} position="top-start">
      <Menu.Target>
        <Box>
          <LayoutNavbarButton
            label={currentService ? `Сервисы: ${currentService.name}` : ''}
            icon={<IconSettings size={24} />}
          />
        </Box>
      </Menu.Target>
      <Menu.Dropdown miw={260}>
        <Flex justify="space-between">
          <Menu.Label>Сервисы</Menu.Label>
          <CloseButton onClick={() => setShowMenu(false)} aria-label="Закрыть" title="Закрыть" />
        </Flex>

        {Object.values(services).map((item: IService) => (
          <Menu.Item
            key={item.code}
            disabled={isCurrentItem(item)}
            onClick={() => setCurrentService(item.code)}
            className={classes.item}
            icon={SERVICE_ICONS[item.code] || SERVICE_ICONS.default}
          >
            <Text>{item.name}</Text>
          </Menu.Item>
        ))}
      </Menu.Dropdown>
    </Menu>
  );
};

export default LayoutNavbarSelect;
