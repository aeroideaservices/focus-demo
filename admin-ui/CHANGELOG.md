# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2023-10-04

### Changed

* [FARM-5115]: Поменять url в CMS ввиду рефакторинга сервиса GEO

### Fixed

* [FARM-4733]: [Frontend] [CMS] [Меню] - Сервис контент. Не отображаются параметры у пункта меню при открытии поп-апа "изменение пункта меню"
* [FARM-5171]: Меню. Создание пункта меню. При создании пункта меню поле domainID отправляется с значением "" а не null
* [FARM-5430]: Предпросмотр акций, контентных страниц, брендзоны. Некорректно отрабатывает
* [FARM-5168]: Конфигурации. Заполнение конфигураций. высвечивается "NaN" после того, как пользователь стер значение в поле с типом данных integer
* [FARM-4381]: [Frontend] [CMS] [Модели] - Создание/Редактирование/Удаление элемента модели. Отображается белая рамка после перечисленных действий
* [FARM-5152]: [Frontend] [CMS] [Акции] [Сниппеты] - Перепутан нейминг у кнопок "Изображение и текст слева" и "Изображение и текст справа"

[FARM-5152]: https://tracker.yandex.ru/FARM-5152
[FARM-4381]: https://tracker.yandex.ru/FARM-4381
[FARM-5168]: https://tracker.yandex.ru/FARM-5168
[FARM-5430]: https://tracker.yandex.ru/FARM-5430
[FARM-5171]: https://tracker.yandex.ru/FARM-5171
[FARM-4733]: https://tracker.yandex.ru/FARM-4733
[FARM-5115]: https://tracker.yandex.ru/FARM-5115
[1.5.0]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.5.0

## [1.4.0] - 2023-08-23

### Added

* [FARM-4789]: Фронтенд. CMS. Абсолютные ссылки для меню

### Fixed

* [FARM-5051]: [Frontend] [CMS] [Акции] - Выпадающий список в сниппетах. Выпадающий список перекрывается другими элементами поп-апа
* [FARM-4962]: Фронтенд. CMS. Конфигурации. Настройки конфигураций. Некорректно отображается выпадающий список при выборе типа данных, при создании новой опции
* [FARM-5048]: [Frontend] [CMS] [Акции] - Невозможно отредактировать акцию, если в ней поменять заполненное поле категория на пустое значение
* [FARM-4404]: [Frontend] [CMS] [Конфигурации] - Доработать отображение полей при заполнении настроек конфигураций с типом данных datetime
* [FARM-5054]: [Frontend] [CMS] [Пагинация] - Поправить баги

### Changed

* [FARM-4979]: [Frontend] [CMS] [Акции] - Реализовать валидацию поля "Ссылка на отфильтрованный каталог"
* [FARM-4735]: [Frontend] [CMS] [Отзывы] - Создание/Изменение отзыва. Реализовать возможность добавления не более 5 файлов в поле "файлы"
* [FARM-4986]: [Frontend] [CMS] [Акции] - Реализовать отсутствие множественного выбора в поле "Категория"
* [FARM-4736]: [Frontend] [CMS] [Модели] - Создание/изменение моделей. Реализовать уведомление под полями с изображениями, если при сохранении они не заполнены и являются обязательными
* Upgrade dependencies: `@tabler/icons-react`, `@tiptap/extension-image`, `@tiptap/extension-link`, `@tiptap/extension-subscript`, `@tiptap/extension-superscript`, `@tiptap/extension-text-align`, `@tiptap/extension-underline`, `@tiptap/pm`, `@tiptap/react`, `@tiptap/starter-kit`
* Upgrade devDependencies: `@types/node`, `@types/react`, `@types/react-redux`, `eslint-plugin-import`, `eslint-plugin-react`, `sass`

[FARM-4736]: https://tracker.yandex.ru/FARM-4736
[FARM-4986]: https://tracker.yandex.ru/FARM-4986
[FARM-4789]: https://tracker.yandex.ru/FARM-4789
[FARM-4735]: https://tracker.yandex.ru/FARM-4735
[FARM-5054]: https://tracker.yandex.ru/FARM-5054
[FARM-4404]: https://tracker.yandex.ru/FARM-4404
[FARM-5048]: https://tracker.yandex.ru/FARM-5048
[FARM-4962]: https://tracker.yandex.ru/FARM-4962
[FARM-4979]: https://tracker.yandex.ru/FARM-4979
[FARM-5051]: https://tracker.yandex.ru/FARM-5051
[1.4.0]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.4.0

## [1.3.0] - 2023-08-07

### Added

* [FARM-4361]: [Frontend] [CMS] [Медиа] - Реализовать множественную загрузку файлов

### Fixed

* [FARM-3308]: [Frontend] [CMS] [Пагинация] - Доработать пейджинг и пагинацию в таблицах CMS

### Changed

* [FARM-3249]: [Frontend] [CMS] - Обновить Mantine до версии 6
* Upgrade dependencies: `@tabler/icons-react`, `react-datepicker`, `react-redux`
* Upgrade devDependencies: `@types/lodash`, `@types/node`, `@types/react`, `@types/react-datepicker`, `eslint`, `eslint-config-prettier`, `eslint-plugin-import`, `eslint-plugin-react`, `sass`

[FARM-3249]: https://tracker.yandex.ru/FARM-3249
[FARM-3308]: https://tracker.yandex.ru/FARM-3308
[FARM-4361]: https://tracker.yandex.ru/FARM-4361
[1.3.0]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.3.0

## [1.2.0] - 2023-07-07

### Added

* [FARM-3466]: [Frontend] [CMS] [Сниппеты] [Сложные] - Реализация сниппетов в CMS

### Fixed

* [FARM-4343]: [Frontend] [CMS] [Доступы] - При авторизации под пользователем, у которого отсутствует доступ к одному сервису, выскакивает белый экран
* [FARM-4539]: [Frontend] [CMS] [Модели] - Баннеры среда ПРОД. Неверно привязывается сервис к запросу на  получение списка категорий в поле "Включенные категории".
* [FARM-4245]: [Frontend] [CMS] [Модели] - Некорректно отображаются поля элементов моделей, если мы до этого создали или отредактировали элемент модели.

### Changed

* Upgrade dependencies: `@editorjs/editorjs`, `@emotion/react`, `dayjs`, `react-datepicker`, `react-redux`
* Upgrade devDependencies: `@babel/core`, `@babel/plugin-proposal-private-property-in-object`, `@babel/plugin-syntax-flow`, `@babel/plugin-transform-react-jsx`, `@types/node`, `@types/react`, `@types/react-dom`, `@typescript-eslint/eslint-plugin`, `@typescript-eslint/parser`, `cpy-cli`, `eslint`, `sass`

[FARM-4343]: https://tracker.yandex.ru/FARM-4343
[FARM-4539]: https://tracker.yandex.ru/FARM-4539
[FARM-3466]: https://tracker.yandex.ru/FARM-3466
[FARM-4245]: https://tracker.yandex.ru/FARM-4245
[1.2.0]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.2.0

## [1.1.0] - 2023-05-25

### Added

* [FARM-2817]: [Frontend] [CMS] - Реализация сниппетов в CMS (простые)

### Fixed

* [FARM-2585]: [Frontend] [CMS] [Модели] - Изменение модели. После изменения модели слетает фильтрация
* [FARM-4056]: [Frontend] [CMS] - Поправить баги связанные с медленным интернетом
* [FARM-3931]: [Frontend] [CMS] [Таблицы] - Поправить баги, которые есть в таблицах

### Changed

* [FARM-3334]: [Frontend] [CMS] [Рефакторинг] - Вынести повторяющийся кусок проверки в thunk'ах store
* Upgrade dependencies: `@editorjs/editorjs`, `@emotion/react`, `qs`, `react-datepicker`, `yup`, `@types/lodash`, `@types/node`, `@types/react`, `@typescript-eslint/eslint-plugin`, `@typescript-eslint/parser`

[FARM-3931]: https://tracker.yandex.ru/FARM-3931
[FARM-3334]: https://tracker.yandex.ru/FARM-3334
[FARM-4056]: https://tracker.yandex.ru/FARM-4056
[FARM-2817]: https://tracker.yandex.ru/FARM-2817
[FARM-2585]: https://tracker.yandex.ru/FARM-2585
[1.1.0]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.1.0

## [1.0.9] - 2023-05-05

### Fixed

* [FARM-1486]: [Frontend] [CMS] [Меню] - При перемещении отсутствует надпись как на макете. Отсутствует выделение вокруг пункта меню, при его перемещении
* [FARM-2539]: [Frontend] [CMS] [Меню] - Поправить оставшиеся баги
* [FARM-3471]: [Frontend] [CMS] [Меню] - Кнопка назад, находящаяся рядом названием меню отрабатывает некорректно
* [FARM-4016]: [Frontend] [CMS] [Меню] - Пустые пункты меню. Прыгает надпись "У вас пока нет пунктов меню"
* [FARM-4014]: [Frontend] [CMS] [Отзывы] - При создании/изменении отзыва вечный прелоадер в поле с добавлением продукта

### Changed

* [FARM-2510]: [Frontend] [CMS] [Backlog] - Реализовать прелоадер согласно макетам
* Upgrade dependencies: `@emotion/react`, `@babel/core`, `@babel/plugin-transform-react-jsx`, `@types/node`, `@types/react`, `@types/react-datepicker`, `@types/react-dom`, `@typescript-eslint/eslint-plugin`, `@typescript-eslint/parser`, `eslint`, `sass`

[FARM-4014]: https://tracker.yandex.ru/FARM-4014
[FARM-4016]: https://tracker.yandex.ru/FARM-4016
[FARM-3471]: https://tracker.yandex.ru/FARM-3471
[FARM-2539]: https://tracker.yandex.ru/FARM-2539
[FARM-2510]: https://tracker.yandex.ru/FARM-2510
[FARM-1486]: https://tracker.yandex.ru/FARM-1486
[1.0.9]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.9

## [1.0.8] - 2023-04-28

### Fixed

* [FARM-4044]: [Frontend] [CMS] Среда прод. Поиск товара при создании/изменении акции. Не передается параметр query в url запроса

[FARM-4044]: https://tracker.yandex.ru/FARM-4044
[1.0.8]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.8

## [1.0.7] - 2023-04-21

### Fixed

* [FARM-2503]: [Frontend] [CMS] [Медиа] - Поправить всплывшие баги
* [FARM-3882]: [Frontend] [CMS] [Медиа] - Странности в поведении верстки в плагине медиа
* [FARM-3924]: [Frontend] [CMS] [Отзывы] - Поправить баги

### Changed

* [FARM-3955]: [Frontend] [CMS] - Обновить логотип и favicon.
* Upgrade dependencies: `@reduxjs/toolkit`, `react-datepicker`, `@types/node`, `@types/react`, `@typescript-eslint/eslint-plugin`, `@typescript-eslint/parser`

[FARM-2503]: https://tracker.yandex.ru/FARM-2503
[FARM-3882]: https://tracker.yandex.ru/FARM-3882
[FARM-3924]: https://tracker.yandex.ru/FARM-3924
[FARM-3955]: https://tracker.yandex.ru/FARM-3955
[1.0.7]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.7

## [1.0.6] - 2023-04-19

### Fixed

* [FARM-1825]: [Frontend] [CMS] [Медиа] - При переименовании файла, на названия файла который ранее был удален, меняется превью файла
* [FARM-3868]: Фронтенд,CMS, Использование useServices в компонентах вызывает их бесконечный перерендер.

[FARM-3868]: https://tracker.yandex.ru/FARM-3868
[FARM-1825]: https://tracker.yandex.ru/FARM-1825
[1.0.6]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.6

## [1.0.5] - 2023-04-18

### Fixed

* [FARM-3863]: Фронтенд, CMS. для полей с ссылками убрать searchApi и заменить на стандартный instance

### Changed

* Upgrade dependencies: `@reduxjs/toolkit`, `yup`, `@types/lodash`

[FARM-3863]: https://tracker.yandex.ru/FARM-3863
[1.0.5]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.5

## [1.0.4] - 2023-04-12

### Changed

* [FARM-2584]: [Frontend] [CMS] [Модели] - В модальном окне "Создание/Изменение элемента модели" реализовать отображение изображения в полях в которых загружается изображение (вместо uuid)
* Upgrade dependencies: `@types/react`, `@typescript-eslint/eslint-plugin`, `@typescript-eslint/parser`, `eslint`, `sass`

[FARM-2584]: https://tracker.yandex.ru/FARM-2584
[1.0.4]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.4

## [1.0.3] - 2023-04-06

### Fixed

* [FARM-3091]: [Frontend] [CMS] [Модели] - Подправить маску, которая уже реализованна в полях с номером телефона
* [FARM-3557]: Фронтенд, CMS. Создание/изменение элемента модели где присутствуют поля с кладрами. При попытке выбора города где будет отображаться элемент модели появляется белый экран

[FARM-3091]:https://tracker.yandex.ru/FARM-3091
[FARM-3557]:https://tracker.yandex.ru/FARM-3557
[1.0.3]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.3

## [1.0.2] - 2023-04-05

### Added

* [FARM-3306]: Фронтенд, CMS. Отзывы. Реализовать возможность воспроизведения видео в CMS

### Fixed

* [FARM-3178]: [Frontend] [CMS] [Отзывы] - Создание отзыва. Поправить баги
* [FARM-3545]: Фронтенд, CMS. Создание/изменение отзыва. Реализовать отображение названия товара и артикула как на макете

### Changed

* Remove dependencies: `i`

[farm-3178]: https://tracker.yandex.ru/FARM-3178
[farm-3306]: https://tracker.yandex.ru/FARM-3306
[farm-3545]: https://tracker.yandex.ru/FARM-3545
[1.0.2]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.2

## [1.0.1] - 2023-04-05

### Fixed

* [FARM-2605]: [Frontend] [CMS] [Конфигурации] - Поправить баги
* [FARM-2934]: [Frontend] [CMS] [Контент] - Увеличить к-во элементов только для строки адреса

### Changed

* Upgrade dependencies: `nanoid`, `@babel/core`, `@babel/plugin-syntax-flow`, `@types/lodash`, `@types/node`, `@types/react`, `@types/react-beautiful-dnd`,`@typescript-eslint/eslint-plugin`,`@typescript-eslint/parser`,`eslint`, `eslint-config-prettier`, `json-server`, `nodemon`, `sass`

[farm-2605]: https://tracker.yandex.ru/FARM-2605
[farm-2934]: https://tracker.yandex.ru/FARM-2934
[1.0.1]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.1

## [1.0.0] - 2023-04-03

### Added

* [FARM-2825]: Фронтенд. Реализация отзывов в CMS.

### Fixed

* [FARM-3170]: [Frontend] [CMS] [Отзывы] - Поправить баги.
* [FARM-3172]: [Frontend] [CMS] [Отзывы] - Поправить баги.
* [FARM-3187]: [Frontend] [CMS] [Отзывы] - Изменение отзыва.
* [FARM-3299]: Фронтенд, CMS. Отзывы. Пропала вкладка с плагином отзывов справа в меню
* [FARM-3307]: Фронтенд, CMS. Отзывы. Переключение сервисов.
* [FARM-3361]: Фронтенд, CMS. Переключение сервисов.
* [FARM-3453]: Фронтенд, CMS. Таблица с отзывами. Поправить баги

### Changed

* Upgrade dependencies: Mantine 5.10.5

[farm-3170]: https://tracker.yandex.ru/FARM-3170
[farm-3172]: https://tracker.yandex.ru/FARM-3172
[farm-2825]: https://tracker.yandex.ru/FARM-2825
[farm-3187]: https://tracker.yandex.ru/FARM-3187
[farm-3299]: https://tracker.yandex.ru/FARM-3299
[farm-3307]: https://tracker.yandex.ru/FARM-3307
[farm-3361]: https://tracker.yandex.ru/FARM-3361
[farm-3453]: https://tracker.yandex.ru/FARM-3453
[1.0.0]: https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/tags/1.0.0
