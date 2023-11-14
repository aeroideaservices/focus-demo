export const getOffset = (page: number, limit: number): number => {
  const numberLimit = Number(limit);
  let numberPage = Number(page);
  let position = 0;

  if (numberPage === 1) return 0;

  for (; numberPage > 1; numberPage--) {
    position = position + numberLimit;
  }

  return position;
};
