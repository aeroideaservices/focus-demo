package entity

import "github.com/google/uuid"

type User struct {
	ID         uuid.UUID `focus:"primaryKey;code:id;column:id;title:ID" validate:"required,notBlank"`
	Name       string    `focus:"title:Имя" validate:"required,min=1,max=450"`
	Email      string    `focus:"title:e-mail;filterable" validate:"required,min=1,max=450"`
	Phone      string    `focus:"title:Телефон;filterable" validate:"required,min=1,max=450"`
	Login      string    `focus:"title:Login;filterable" validate:"required,min=1,max=450"`
	LastName   string    `focus:"title:Фамилия" validate:"required,min=1,max=450"`
	MiddleName string    `focus:"title:Отчество" validate:"required,min=1,max=450"`
}

func (User) TableName() string {
	return "users"
}

func (User) ModelTitle() string {
	return "Пользователи"
}
