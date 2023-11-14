export const getPages = (total: number | string, limit: number) => {
  const numberTotal = Number(total);
  const numberLimit = limit;

  return Math.ceil(numberTotal / numberLimit);
};
