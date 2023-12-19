package postgres

import (
	"context"
	"gorm.io/gorm"
)

type FixtureRepository struct {
	db *gorm.DB
}

func NewFixtureRepository(db *gorm.DB) *FixtureRepository {
	return &FixtureRepository{db: db}
}

func (r FixtureRepository) Create(ctx context.Context, entity any) error {
	return r.db.WithContext(ctx).Save(entity).Error
}

func (r FixtureRepository) DeleteAll(ctx context.Context, entity any) error {
	return r.db.WithContext(ctx).Where("TRUE").Delete(entity).Error
}
