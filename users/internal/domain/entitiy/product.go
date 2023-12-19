package entity

import (
	"github.com/aeroideaservices/focus/media/plugin/entity"
	"github.com/aeroideaservices/focus/services/db/db_types/array"
	"github.com/google/uuid"
)

type Product struct {
	ID         uuid.UUID         `focus:"primaryKey;code:id;column:id;title:ID"`
	Name       string            `focus:"title:Название;filterable" validate:"required,min=1,max=50"`
	ExternalId uint              `focus:"title:Артикул;filterable;unique" validate:"required,notBlank"`
	CategoryId uuid.UUID         `focus:"-" validate:"-"`
	Category   Category          `focus:"title:Категория;view:select;viewExtra:categorySelect" validate:"required,structonly,notBlank"`
	Gallery    []entity.Media    `gorm:"many2many:products_media" focus:"title:Галерея;media;view:media;viewExtra:productGallery" validate:"omitempty,unique,dive,notBlank"`
	Colors     array.StringArray `focus:"title:Цвета" validate:"omitempty,unique,dive,iscolor"`
}

func (Product) TableName() string {
	return "products"
}

func (Product) ModelTitle() string {
	return "Товары"
}
