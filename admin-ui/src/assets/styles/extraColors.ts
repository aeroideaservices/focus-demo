export type ExtraColors = 'caribbean-green' | 'pomegranate' | 'science-blue' | 'jungle-mist';

export const extraColors: Record<
  ExtraColors,
  [string, string, string, string, string, string, string, string, string, string]
> = {
  'caribbean-green': [
    '#ebfef7',
    '#cefdeb',
    '#a1f9da',
    '#64f1ca',
    '#27e0b3',
    '#02c39a',
    '#00a281',
    '#00826a',
    '#006655',
    '#005448',
  ],
  pomegranate: [
    '#fef3f2',
    '#ffe3e1',
    '#ffccc9',
    '#fea9a3',
    '#fb776e',
    '#f24236',
    '#e02e22',
    '#bc2319',
    '#9c2018',
    '#81221b',
  ],
  'science-blue': [
    '#ecfbff',
    '#d4f5ff',
    '#b2f0ff',
    '#7de9ff',
    '#40d8ff',
    '#14bcff',
    '#009cff',
    '#0084ff',
    '#006fd6',
    '#085aa0',
  ],
  'jungle-mist': [
    '#f5f7f9',
    '#e7edf2',
    '#d5dee8',
    '#bfcedb',
    '#97aec3',
    '#7d96b4',
    '#6b81a5',
    '#5f7296',
    '#515e7c',
    '#444e64',
  ],
};

// TODO убрал так-как этот кусок вызывает ошибку при сборке на сервере
// скорее всего необходимо переходить с npm на yarn что бы избежать ее
// declare module '@mantine/core' {
//   export interface MantineThemeColorsOverride {
//     colors: Record<DefaultMantineColor | ExtraColors, Tuple<string, 10>>;
//   }
// }
