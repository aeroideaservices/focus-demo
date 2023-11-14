import { FC, useState } from 'react';
import { TextInput } from '@mantine/core';

interface IFiasInputs {
  label: string;
  placeholder: string;
  required?: boolean;
  value: string;
  onChange: (e: any) => void;
  disabled?: boolean;
}

const FiasInputs: FC<IFiasInputs> = ({ label, required, value, disabled, ...rest }) => {
  const [includedInput, setIncludedInput] = useState(JSON.parse(value)?.included?.kladr);
  const [excludedInput, setExcludedInput] = useState(JSON.parse(value)?.excluded?.kladr);

  const handleChange = (e: any) => {
    if (e.target.placeholder === 'Включенные города') {
      setIncludedInput(e.target.value);
    } else {
      setExcludedInput(e.target.value);
    }
    rest.onChange(JSON.stringify({ included: includedInput, excluded: excludedInput }));
  };

  return (
    <>
      <h4>{label}</h4>

      <TextInput
        label={'Включенные города'}
        placeholder={'Включенные города'}
        mb={24}
        required={required}
        value={includedInput}
        disabled={disabled}
        onChange={handleChange}
      />
      <TextInput
        label={'Исключенные города'}
        placeholder={'Исключенные города'}
        mb={24}
        required={required}
        disabled={disabled}
        value={excludedInput}
        onChange={handleChange}
      />
    </>
  );
};

export default FiasInputs;
