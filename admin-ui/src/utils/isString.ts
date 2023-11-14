export function isString(v: string | unknown): v is string {
  return typeof v === 'string';
}
