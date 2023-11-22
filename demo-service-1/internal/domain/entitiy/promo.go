package entity

import (
	"github.com/aeroideaservices/focus/media/plugin/entity"
	"github.com/aeroideaservices/focus/services/db/db_types/datetime"
	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type Promo struct {
	Id                  uuid.UUID            `focus:"title:ID;primaryKey;position:1"`
	Code                string               `focus:"title:Код;shownInList;disabled:update;unique;viewExtra:sluggableOnTitle;sortable;filterable" validate:"required,sluggable"`
	Title               string               `focus:"title:Название;sortable;filterable;position:2" validate:"required"`
	ImageId             *uuid.UUID           `focus:"-" validate:"-"`
	Image               *entity.Media        `focus:"title:Иконка;media;hidden:list;viewExtra:promosMedia"`
	Active              bool                 `focus:"title:Активность;filterable"`
	ActiveFrom          datetime.DateTimeUTC `focus:"title:Дата начала акции;view:dateTimePicker;filterable;time" validate:"required,notBlank"`
	ActiveTo            datetime.DateTimeUTC `focus:"title:Дата окончания акции;view:dateTimePicker;filterable;time" validate:"required,notBlank,gtfield=ActiveFrom"`
	RedirectLink        string               `focus:"title:Ссылка для перехода (акция без детальной страницы);hidden:list" validate:"omitempty,uri"`
	Sort                int                  `focus:"title:Сортировка"`
	InfoEmail           string               `focus:"title:Контактный email;view:emailInput;hidden:list" validate:"omitempty,email"`
	InfoPhone           string               `focus:"title:Контактный телефон;view:phoneInput;hidden:list" validate:"omitempty,phone"`
	Rating              int                  `focus:"title:Рейтинг;view:rating" validate:"omitempty,min=0,max=5"`
	Date                datetime.Date        `focus:"title:Дата;view:datePickerInput;time"`
	FilteredCatalogLink string               `focus:"title:Ссылка на отфильтрованный каталог;hidden:list" validate:"omitempty,uri"`
	CategoryId          *uuid.UUID           `focus:"-"`
	Category            *Category            `focus:"title:Категория;view:select;viewExtra:categorySelect;hidden:list" validate:"omitempty,structonly"`
	Products            []Product            `focus:"title:Товары на детальной странице акции;view:select;viewExtra:selectProducts;hidden:list;many2many:promos_products;joinSort:sort" gorm:"many2many:promos_products" validate:"omitempty,max=50,unique=ID,dive,notBlank,structonly"`
	ShortDescription    string               `focus:"title:Краткое описание;view:textarea;hidden:list"`
	PreviewDescription  string               `focus:"title:Описание превью акции;view:wysiwyg;hidden:list"`
	Description         string               `focus:"title:Описание акции;view:editorJs;viewExtra:promoEditorJs;hidden:list" validate:"omitempty,json"`
}

func (Promo) TableName() string {
	return "promos"
}

func (Promo) ModelTitle() string {
	return "Акции"
}

func (p Promo) AfterCreate(tx *gorm.DB) error {
	return p.setProductsSort(tx)
}

func (p Promo) AfterUpdate(tx *gorm.DB) error {
	return p.setProductsSort(tx)
}

func (p Promo) AfterSave(tx *gorm.DB) error {
	return p.setProductsSort(tx)
}

func (p Promo) setProductsSort(tx *gorm.DB) error {
	if len(p.Products) == 0 {
		return nil
	}

	var promoProducts []PromoProduct
	for i, product := range p.Products {
		promoProducts = append(promoProducts, PromoProduct{
			Sort:      i + 1,
			PromoId:   p.Id,
			ProductId: product.ID,
		})
	}
	return tx.Clauses(clause.OnConflict{
		Columns:   []clause.Column{{Name: "promo_id"}, {Name: "product_id"}}, // key column
		DoUpdates: clause.AssignmentColumns([]string{"sort"}),                // column needed to be updated
	}).Save(promoProducts).Error
}

type PromoProduct struct {
	PromoId   uuid.UUID
	ProductId uuid.UUID
	Sort      int
}

func (PromoProduct) TableName() string {
	return "promos_products"
}
