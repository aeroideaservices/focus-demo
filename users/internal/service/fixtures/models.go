package fixtures

import (
	"encoding/json"
	"github.com/aeroideaservices/focus/models/examples"
	"io"
	"os"
	entity "users/internal/domain/entitiy"
)

type CategoryFixture struct{}

func (CategoryFixture) GetEntity() any {
	return &entity.User{}
}

func (f CategoryFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/models/categories.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []examples.Category
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

type ProductFixture struct{}

func (ProductFixture) GetEntity() any {
	return &examples.Product{}
}

func (f ProductFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/models/products.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []examples.Product
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

type PromoFixture struct{}

func (PromoFixture) GetEntity() any {
	return &examples.Promo{}
}

func (f PromoFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/models/promos.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []examples.Promo
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

type StoreFixture struct{}

func (StoreFixture) GetEntity() any {
	return &examples.Store{}
}

func (f StoreFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/models/stores.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []examples.Store
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
