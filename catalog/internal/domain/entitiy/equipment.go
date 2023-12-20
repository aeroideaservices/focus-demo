package entity

import "github.com/google/uuid"

type Equipment struct {
	ID   uuid.UUID `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	Name string    `focus:"title:Название;filterable" validate:"required,min=1,max=50"`
	Code string    `focus:"title:Код;unique;sluggableOn:name;disabled:update;sortable;filterable;viewExtra:sluggableOnName" validate:"required,notBlank,sluggable"`
}

func (Equipment) TableName() string {
	return "equipments"
}

func (Equipment) ModelTitle() string {
	return "Комплектация"
}
