package fixtures

import (
	"encoding/json"
	"github.com/aeroideaservices/focus/configurations/plugin/entity"
	"io"
	"os"
)

type ConfigurationFixture struct{}

func (ConfigurationFixture) GetEntity() any {
	return &entity.Configuration{}
}

func (f ConfigurationFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/configurations/configurations.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.Configuration
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

type OptionFixture struct{}

func (OptionFixture) GetEntity() any {
	return &entity.Option{}
}

func (f OptionFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/configurations/options.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.Option
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
