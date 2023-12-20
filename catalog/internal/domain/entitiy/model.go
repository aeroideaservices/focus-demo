package entity

import "github.com/google/uuid"

type Model struct {
	ID      uuid.UUID  `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	Name    string     `focus:"title:Название;filterable" validate:"required,min=1,max=50"`
	Code    string     `focus:"title:Код;unique;sluggableOn:name;disabled:update;sortable;filterable;viewExtra:sluggableOnName" validate:"required,notBlank,sluggable"`
	BrandId *uuid.UUID `focus:"-"`
	Brand   *Brand     `focus:"title:Марка;view:select;viewExtra:brandSelect;hidden:list" validate:"omitempty,structonly"`
}

func (Model) TableName() string {
	return "models"
}

func (Model) ModelTitle() string {
	return "Модели"
}