package fixtures

import (
	"encoding/json"
	"github.com/aeroideaservices/focus/forms/plugin/entity"
	"io"
	"os"
)

type FormFixture struct{}

func (FormFixture) GetEntity() any {
	return &entity.Form{}
}

func (f FormFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/forms/forms.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.Form
	err = json.Unmarshal(byteValue, &data)
	if err != nil {
		return nil, err
	}

	err = jsonFile.Close()
	if err != nil {
		return nil, err
	}

	return data, nil
}

type FormFieldFixture struct{}

func (FormFieldFixture) GetEntity() any {
	return &entity.FormField{}
}

func (f FormFieldFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/forms/form-fields.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.FormField
	err = json.Unmarshal(byteValue, &data)
	if err != nil {
		return nil, err
	}

	err = jsonFile.Close()
	if err != nil {
		return nil, err
	}

	return data, nil
}

type FormResultFixture struct{}

func (FormResultFixture) GetEntity() any {
	return &entity.FormResult{}
}

func (f FormResultFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/forms/form-results.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.FormResult
	err = json.Unmarshal(byteValue, &data)
	if err != nil {
		return nil, err
	}

	err = jsonFile.Close()
	if err != nil {
		return nil, err
	}

	return data, nil
}
