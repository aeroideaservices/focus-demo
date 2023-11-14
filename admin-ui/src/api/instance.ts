import axios from 'axios';
import qs from 'qs';

import { getCookie, setCookie } from '@/utils/cookie';
import { tokenGetAndRefresh } from '@/utils/token';

const api = axios.create({
  baseURL: process.env.PUBLIC_API_URL,
  paramsSerializer: (params) => {
    return qs.stringify(params, { indices: false }); // param=value1&param=value2
  },
});

export const objectToJson = (obj: Record<string, unknown>): string => {
  return JSON.stringify(obj, null, 0);
};

const requestMiddleware = async (config: any) => {
  const now = Date.now();
  const cookiesToken = getCookie('token') as string;
  const tokenInfo = cookiesToken ? JSON.parse(cookiesToken) : null;
  let accessToken = null;

  if (!(window.location.pathname === '/auth')) {
    // Если токена нет в cookie сбрасываем пользователя на стр входа
    if (!cookiesToken) {
      setCookie('token', '');
      window.location.assign('/auth');
    }

    // Проверяем время жизни refreshToken из cookie - если протух,
    // сбрасываем пользователя на стр входа
    // если нет, то обновляем токен
    if (tokenInfo && tokenInfo.refreshExpiresAt && now > tokenInfo.refreshExpiresAt) {
      setCookie('token', '');
      window.location.assign('/auth');
    } else {
      await tokenGetAndRefresh();
    }
  }

  if (cookiesToken) {
    accessToken = JSON.parse(cookiesToken).access_token;
  }

  // при запросе на рефреш токен им нужен не access токен, который берется из куков
  // а рефреш токен, который прокидывается в конкретных запросах. По этому для них
  // мы accesstoken не прокидываем!
  // const ifThrowToken =
  //   accessToken &&
  //   config.url !== URLS.users.auth.customerRefresh &&
  //   config.url !== URLS.users.signIn.authByRefresh;
  // const tokenFromHeaders = ifThrowToken ? { Authorization: `Bearer ${accessToken}` } : undefined;
  const tokenFromHeaders = { Authorization: `Bearer ${accessToken}` };

  return {
    ...config,
    headers: {
      ...config.headers,
      ...tokenFromHeaders,
    },
  };
};

api.interceptors.request.use((config) => {
  const service = localStorage.getItem('service')?.replace(/"/g, '');

  if (config.headers) {
    if (!config?.headers['Service-Code']) {
      config.headers['Service-Code'] = service ? service : 'content';
    }
  }
  return config;
});

api.interceptors.request.use(requestMiddleware, (error) => {
  return Promise.reject(error);
});

api.interceptors.response.use(
  (response) => {
    // Type response middleware here
    return response;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default api;
