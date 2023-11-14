import { FC } from 'react';
import { NavLink } from 'react-router-dom';
import {
  Box,
  createStyles,
  getStylesRef,
  Group,
  Text,
  UnstyledButton,
  UnstyledButtonProps,
} from '@mantine/core';

interface ILayoutNavbarButton extends UnstyledButtonProps {
  label: string;
  path?: string;
  icon?: React.ReactNode;
  onClick?: () => void;
}

const useStyles = createStyles((theme) => ({
  link: {
    display: 'block',
    width: '100%',
    maxWidth: '100%',
    height: 48,
    paddingLeft: 24,
    borderRight: `2px solid transparent`,
    color: '#bfcedb',
    overflow: 'hidden',
    textDecoration: 'none',
    transition: 'color 0.25s ease, border-color 0.25s ease',

    '&:hover': {
      color: `${theme.colors['science-blue'][9]} !important`,
      borderRightColor: `${theme.colors['science-blue'][9]}`,

      [`& .${getStylesRef('text')}`]: {
        color: `${theme.colors['science-blue'][9]} !important`,
      },
    },
  },
  active: {
    color: `${theme.colors['science-blue'][9]} !important`,
    borderRightColor: `${theme.colors['science-blue'][9]} !important`,
    pointerEvents: 'none',

    [`& .${getStylesRef('text')}`]: {
      color: `${theme.colors['science-blue'][9]} !important`,
    },
  },
  text: {
    ref: getStylesRef('text'),
    color: '#121212',
    transition: 'color 0.25s ease',
  },
}));

const LayoutNavbarButton: FC<ILayoutNavbarButton> = ({ label, icon, path, onClick }) => {
  const { classes } = useStyles();

  return (
    <>
      {path ? (
        <NavLink
          to={path}
          className={({ isActive }) =>
            isActive ? `${classes.link} ${classes.active}` : `${classes.link}`
          }
        >
          <Group spacing={20} noWrap sx={{ height: 48, alignItems: 'center' }}>
            <Box title={label} w={24} h={24} fz={24} sx={{ display: 'flex', alignItems: 'center' }}>
              {icon}
            </Box>
            <Text size="md" truncate className={classes.text}>
              {label}
            </Text>
          </Group>
        </NavLink>
      ) : (
        <UnstyledButton className={classes.link} onClick={onClick}>
          <Group spacing={20} noWrap sx={{ height: 48, alignItems: 'center' }}>
            <Box title={label} w={24} h={24} fz={24} sx={{ display: 'flex', alignItems: 'center' }}>
              {icon}
            </Box>
            <Text size="md" truncate className={classes.text}>
              {label}
            </Text>
          </Group>
        </UnstyledButton>
      )}
    </>
  );
};

export default LayoutNavbarButton;
