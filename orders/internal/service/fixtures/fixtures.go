package fixtures

import (
	"context"
)

type Fixture interface {
	FixturesData() (any, error)
	GetEntity() any
}

type FixtureRepository interface {
	DeleteAll(ctx context.Context, entity any) error
	Create(ctx context.Context, entity any) error
}

type FixtureService struct {
	fixtures   []Fixture
	repository FixtureRepository
}

func NewFixtureService(fixtures []Fixture, repository FixtureRepository) *FixtureService {
	return &FixtureService{fixtures: fixtures, repository: repository}
}

func (f FixtureService) RunFixtures(ctx context.Context) error {
	for _, fix := range f.fixtures {
		data, err := fix.FixturesData()
		if err != nil {
			return err
		}
		if err := f.repository.DeleteAll(ctx, fix.GetEntity()); err != nil {
			return err
		}
		if err := f.repository.Create(ctx, data); err != nil {
			return err
		}
	}

	return nil
}
