package translations

import (
	et "github.com/aeroideaservices/focus/services/error-translator"
)

var ErrTranslations = []et.Translation{
	{
		Tag:         "model-element.field.wrong",
		Translation: "Передано неверное значение поля \"{0}\".",
	},
	{
		Tag:         "model-element.field.unique",
		Translation: "Поле \"{0}\" должно быть уникальным.",
	},
	{
		Tag:         "folder.conflict",
		Translation: "Папка с таким названием уже существует.",
	},
	{
		Tag:         "folder.recursion",
		Translation: "Невозможно сделать дочернюю папку родительской.",
	},
	{
		Tag:         "folder.moving-same-folder",
		Translation: "Папка уже лежит в этой папке.",
	},
	{
		Tag:         "folder.renaming-same-name",
		Translation: "У папки уже такое название.",
	},
	{
		Tag:         "media.renaming-same-name",
		Translation: "У медиа уже такое название.",
	},
	{
		Tag:         "media.moving-same-folder",
		Translation: "Медиа уже лежит в этой папке.",
	},
	{
		Tag:         "media.conflict",
		Translation: "Медиа с таким названием уже существует.",
	},
	{
		Tag:         "folder.not-found",
		Translation: "Папка не найдена.",
	},
	{
		Tag:         "media.not-found",
		Translation: "Медиа не найдено.",
	},
	{
		Tag:         "media.not-exists",
		Translation: "Один из медиа файлов не найден.",
	},
	{
		Tag:         "media.file.size",
		Translation: "Размер медиа файла не может превышать 10МБ.",
	},
	{
		Tag:         "conf.exists",
		Translation: "Конфигурация с таким символьным кодом уже существует.",
	},
	{
		Tag:         "opt.exists",
		Translation: "Настройка с таким символьным кодом уже существует.",
	},
	{
		Tag:         "opt.linked-to-another",
		Translation: "Настройка привязана к другой конфигурации.",
	},
	{
		Tag:         "field-not-updatable",
		Translation: "Поле {0} нельзя обновлять.",
	},
	{
		Tag:         "media-not-imported",
		Translation: "Работа с файлами недоступна, так как плагин media не установлен.",
	},
	{
		Tag:         "conf.not-found",
		Translation: "Конфигурация не найдена.",
	},
	{
		Tag:         "opt.not-found",
		Translation: "Настройка не найдена.",
	},
	{
		Tag:         "form-field.conflict",
		Translation: "Поле с таким кодом уже существует в этой форме.",
	},
	{
		Tag:         "form.conflict",
		Translation: "Форма с таким кодом уже существует.",
	},
	{
		Tag:         "mail-template.not-found",
		Translation: "Шаблон письма не найден.",
	},
	{
		Tag:         "mail-templates-not-imported",
		Translation: "Плагин \"Шаблоны писем\" не подключен.",
	},
	{
		Tag:         "incorrect-field-code",
		Translation: "Передан неверный код поля.",
	},
	{
		Tag:         "form.not-found",
		Translation: "Форма не найдена.",
	},
	{
		Tag:         "form-field.not-found",
		Translation: "Поле формы не найдено.",
	},
	{
		Tag:         "form-result.not-found",
		Translation: "Результат формы не найден.",
	},
	{
		Tag:         "menu.conflict",
		Translation: "Меню с таким кодом уже существует.",
	},
	{
		Tag:         "menu-item.position-too-large",
		Translation: "Позиция пункта меню слишком большая.",
	},
	{
		Tag:         "menu-item.max-depth-exceeded",
		Translation: "Достигнута максимальная вложенность пунктов меню.",
	},
	{
		Tag:         "menu.not-found",
		Translation: "Меню не найдено.",
	},
	{
		Tag:         "menu-item.not-found",
		Translation: "Пункт меню не найден.",
	},
}
