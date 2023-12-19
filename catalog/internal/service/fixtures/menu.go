package fixtures

import (
	"encoding/json"
	"github.com/aeroideaservices/focus/menu/plugin/entity"
	"io"
	"os"
)

type MenuFixture struct{}

func (MenuFixture) GetEntity() any {
	return &entity.Menu{}
}

func (f MenuFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/menu/menus.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.Menu
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

type MenuItemFixture struct{}

func (MenuItemFixture) GetEntity() any {
	return &entity.MenuItem{}
}

func (f MenuItemFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/menu/menu-item.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.MenuItem
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
