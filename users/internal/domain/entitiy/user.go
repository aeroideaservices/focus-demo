package entity

import "github.com/google/uuid"

type User struct {
	ID         uuid.UUID `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	Name       string    `focus:"title:Имя;filterable" validate:"required,min=1,max=450"`
	LastName   string    `focus:"title:Фамилия;filterable" validate:"required,min=1,max=450"`
	MiddleName string    `focus:"title:Отчество;filterable" validate:"required,min=1,max=450"`
}

func (User) TableName() string {
	return "users"
}

func (User) ModelTitle() string {
	return "Пользователи"
}
