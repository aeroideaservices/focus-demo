package entity

import (
	"github.com/aeroideaservices/focus/media/plugin/entity"
	"github.com/aeroideaservices/focus/services/db/db_types/datetime"
	"github.com/google/uuid"
)

type Promo struct {
	Id                 uuid.UUID            `focus:"hidden:list;title:ID;primaryKey;position:1"`
	Code               string               `focus:"title:Код;shownInList;disabled:update;unique;viewExtra:sluggableOnTitle;sortable;filterable" validate:"required,sluggable"`
	Title              string               `focus:"title:Название;sortable;filterable;position:2" validate:"required"`
	ImageId            *uuid.UUID           `focus:"-" validate:"-"`
	Image              *entity.Media        `focus:"title:Иконка;media;hidden:list;viewExtra:promosMedia"`
	Active             bool                 `focus:"title:Активность;filterable"`
	ActiveFrom         datetime.DateTimeUTC `focus:"title:Дата начала акции;view:dateTimePicker;filterable;time" validate:"required,notBlank"`
	ActiveTo           datetime.DateTimeUTC `focus:"title:Дата окончания акции;view:dateTimePicker;filterable;time" validate:"required,notBlank,gtfield=ActiveFrom"`
	Sort               int                  `focus:"title:Сортировка"`
	ShortDescription   string               `focus:"title:Краткое описание;view:textarea;hidden:list"`
	PreviewDescription string               `focus:"title:Описание превью акции;view:wysiwyg;hidden:list"`
	Description        string               `focus:"title:Описание акции;view:editorJs;viewExtra:promoEditorJs;hidden:list" validate:"omitempty,json"`
}

func (Promo) TableName() string {
	return "promos"
}

func (Promo) ModelTitle() string {
	return "Акции"
}
