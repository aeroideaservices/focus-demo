package entity

import "github.com/google/uuid"

type Category struct {
	ID         uuid.UUID  `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	Name       string     `focus:"title:Название;filterable" validate:"required,min=1,max=50"`
	Code       string     `focus:"title:Код;unique;sluggableOn:name;disabled:update;sortable;filterable;viewExtra:sluggableOnName" validate:"required,notBlank,sluggable"`
	Category   *Category  `focus:"title:Родительская категория;view:select;viewExtra:categorySelect;hidden:list" validate:"omitempty,structonly"`
	CategoryID *uuid.UUID `focus:"-"`
}

func (Category) TableName() string {
	return "categories"
}

func (Category) ModelTitle() string {
	return "Категории"
}
