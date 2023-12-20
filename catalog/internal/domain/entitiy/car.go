package entity

import (
	"github.com/aeroideaservices/focus/media/plugin/entity"
	"github.com/google/uuid"
)

type Car struct {
	ID          uuid.UUID     `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	Name        string        `focus:"title:Название;filterable" validate:"required,min=1,max=50"`
	ImageId     *uuid.UUID    `focus:"-" validate:"-"`
	Image       *entity.Media `focus:"title:Изображения;media;hidden:list;viewExtra:pluginsMedia"`
	Vin         string        `focus:"title:VIN;filterable" validate:"required,min=1,max=50"`
	Year        string        `focus:"title:Год выпуска;filterable" validate:"required"`
	BrandId     *uuid.UUID    `focus:"-"`
	Brand       *Brand        `focus:"title:Марка;view:select;viewExtra:brandSelect;hidden:list" validate:"omitempty,structonly"`
	ModelId     *uuid.UUID    `focus:"-"`
	Model       *Model        `focus:"title:Модель;view:select;viewExtra:modelSelect;hidden:list" validate:"omitempty,structonly"`
	ColorId     *uuid.UUID    `focus:"-"`
	Color       *Color        `focus:"title:Цвет;view:select;viewExtra:colorSelect;hidden:list" validate:"omitempty,structonly"`
	RimId       *uuid.UUID    `focus:"-"`
	Rim         *Rim          `focus:"title:Размер дисков;view:select;viewExtra:rimSelect;hidden:list" validate:"omitempty,structonly"`
	EquipmentId *uuid.UUID    `focus:"-"`
	Equipment   *Equipment    `focus:"title:Комплектация;view:select;viewExtra:equipmentSelect;hidden:list" validate:"omitempty,structonly"`
}

func (Car) TableName() string {
	return "car"
}

func (Car) ModelTitle() string {
	return "Автомобили"
}
