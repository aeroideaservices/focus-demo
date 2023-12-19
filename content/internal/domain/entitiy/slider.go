package entity

import (
	"github.com/aeroideaservices/focus/media/plugin/entity"
	"github.com/aeroideaservices/focus/services/db/db_types/datetime"
	"github.com/google/uuid"
)

type Sliders struct {
	Id         uuid.UUID            `focus:"hidden:list;title:ID;primaryKey;position:1"`
	Code       string               `focus:"title:Код;shownInList;disabled:update;unique;viewExtra:sluggableOnTitle;sortable;filterable" validate:"required,sluggable"`
	Title      string               `focus:"title:Название;sortable;filterable;position:2" validate:"required"`
	ImageId    *uuid.UUID           `focus:"-" validate:"-"`
	Image      *entity.Media        `focus:"title:Слайд;media;viewExtra:promosMedia"`
	Image2xId  *uuid.UUID           `focus:"-" validate:"-"`
	Image2x    *entity.Media        `focus:"title:Слайд(2x);media;viewExtra:promosMedia"`
	Active     bool                 `focus:"title:Активность;filterable"`
	ActiveFrom datetime.DateTimeUTC `focus:"title:Дата начала активности;view:dateTimePicker;filterable;time" validate:"required,notBlank"`
	ActiveTo   datetime.DateTimeUTC `focus:"title:Дата окончания активности;view:dateTimePicker;filterable;time" validate:"required,notBlank,gtfield=ActiveFrom"`
	Sort       int                  `focus:"title:Сортировка"`
}

func (Sliders) TableName() string {
	return "sliders"
}

func (Sliders) ModelTitle() string {
	return "Слайдер на главной"
}
