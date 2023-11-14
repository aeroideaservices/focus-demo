module.exports = status => {
  switch (status) {
    case 400: 
    case 404:
      return {
        message: 'Клиентская ошибка'
      };
    case 500:
      return {
        message: 'Серверная ошибка'
      };
    default:
      return {
        message: 'Неизвестная ошибка'
      };
  }
};
