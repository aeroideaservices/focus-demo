package fixtures

import (
	"encoding/json"
	"github.com/aeroideaservices/focus/mail-templates/plugin/entity"
	"io"
	"os"
)

type MailTemplateFixture struct{}

func (MailTemplateFixture) GetEntity() any {
	return &entity.MailTemplate{}
}

func (f MailTemplateFixture) FixturesData() (any, error) {
	jsonFile, err := os.Open("fixtures_data/mail-templates/mail-templates.json")
	if err != nil {
		return nil, err
	}

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		return nil, err
	}

	var data []entity.MailTemplate
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
