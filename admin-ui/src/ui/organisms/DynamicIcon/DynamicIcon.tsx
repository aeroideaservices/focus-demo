import { FC } from 'react';
import loadable from '@loadable/component';
import { IconLoader } from '@tabler/icons-react';

const AsyncIcon = loadable(() => import(`@tabler/icons-react`), {
  resolveComponent: (components: any, props: Record<string, string>) => components[props.name],
  fallback: <IconLoader />,
});

interface DynamicIconProps {
  name: string;
}

const DynamicIcon: FC<DynamicIconProps> = ({ name }) => {
  return <AsyncIcon name={name} />;
};

export default DynamicIcon;
