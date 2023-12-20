package entity

import "github.com/google/uuid"

type Rim struct {
	ID   uuid.UUID `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	Name string    `focus:"title:Название;filterable" validate:"required,min=1,max=50"`
	Size string    `focus:"title:Размер;unique;sluggableOn:name;disabled:update;sortable;filterable;viewExtra:sluggableOnName" validate:"required,notBlank,sluggable"`
}

func (Rim) TableName() string {
	return "rim"
}

func (Rim) ModelTitle() string {
	return "Колесные диски"
}
