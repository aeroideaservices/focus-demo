package entity

import "github.com/google/uuid"

type Order struct {
	ID         uuid.UUID  `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	StatusId   *uuid.UUID `focus:"-"`
	Status     *Status    `focus:"title:Статус;view:select;viewExtra:statusSelect;hidden:list" validate:"omitempty,structonly"`
	AutoParams string     `focus:"title:Информация об автомобиле" validate:"required,min=1,max=450"`
	Name       string     `focus:"title:Имя пользователя;filterable" validate:"required,min=1,max=450"`
	Login      string     `focus:"title:Login пользователя;filterable" validate:"required,min=1,max=450"`
	Email      string     `focus:"title:e-mail пользователя;filterable" validate:"required,min=1,max=450"`
	LastName   string     `focus:"title:Фамилия пользователя;filterable" validate:"required,min=1,max=450"`
	MiddleName string     `focus:"title:Отчество пользователя" validate:"required,min=1,max=450"`
}

func (Order) TableName() string {
	return "orders"
}

func (Order) ModelTitle() string {
	return "Заявки"
}
