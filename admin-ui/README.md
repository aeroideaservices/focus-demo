<div align="center">

# FOCUS UI

[CHANGELOG.md]

[CHANGELOG.md]:https://gitlab.aeroidea.ru/internal-projects/focus-group/focus-ui/-/blob/master/CHANGELOG.md
</div>

В основе проекта лежат:

* [Create React App](https://github.com/facebook/create-react-app)
* [Redux Toolkit](https://redux-toolkit.js.org/introduction/getting-started)
* [Mantine](https://mantine.dev/)

## Прочий стек

* [Node.JS](https://nodejs.org/en/download/) версии 14 и выше
* [Yarn](https://yarnpkg.com/) (Использовать другие пакетные менеджеры не рекомендуется из соображений оптимизации)
* [TypeScript](https://www.typescriptlang.org/)
* [Sass](https://sass-scss.ru/)
* [CSS Modules](https://habr.com/ru/post/335244/)
* [Axios](https://axios-http.com/)

## Доступные команды

* `yarn start` - запуск в режиме разработки
* `yarn build` - сборка проекта
* `yarn run lint` - линтинг проекта
* `yarn run mock` - запуск mock сервера

## Работа с ветками

* Создаём ветку от `master` ветки с именем `FARM-XXXX`, где `XXXX` номер задачи.
* После выполнения задачи ставим MR в ветку `develop`, название MR должно начинаться с имени ветки, пример: `FARM-XXXX: Название задачи`
* Обязательно прикрепить ссылку на MR в задачу.
* Далее переходим в [репозиторий CMS](https://gitlab.aeroidea.ru/farmperspektiva/cms)
* Переходим на вкладку CI/CD - Pipelines и нажимаем `Run pipline`
* Выбираем ветку `develop` и жмём `Run pipline`
* После того как выполнятся все задачи пайплайна переводим задачу в тестирование.

## Процесс релиза

Общий процесс релиза описан в [wiki](https://wiki.aeroidea.ru/doc/reliz-flou-a-tFjOcJTpdJ), ниже представлен процесс релиза с учетом особенностей CMS.

* QA Lead в начале спринта создаёт релизную ветку от master, в формате `Release-*`, где `*` номер спринта.
* После того как все задачи протестированы, проведён регресс на препроде QA Lead пишет разработчику о готовности релизной ветки к слиянию с мастером.
* Разработчик переходит в релизную ветку:
  * Обновляет версии пакетов (какие возможно) и проверяет что сборка работает без ошибок:
    * Запускаем команду `yarn run lint`
    * Запускаем команду `yarn run build`
    * Запускаем команду `yarn run start`
  * Обновляет версию проекта в `package.json`
  * Заполняет изменения по релизу в файле `CHANGELOG.md`
  * Коммитит эти изменения в релизную ветку.
  * Сообщает QA Lead о готовности ветки.
* QA Lead создаёт МР релизной ветки в `master`, сигнализирует в чате о готовности релиза в прод, заливает МР в `master`, и деплоит продакшен:
  * Переходит в [репозиторий CMS](https://gitlab.aeroidea.ru/farmperspektiva/cms)
  * Переходит на вкладку CI/CD - Pipelines и нажимаем `Run pipline`
  * Выбирает ветку `master` и жмёт `Run pipline`
* Разработчик создаёт новый тег от ветки `master` с именем версии релиза `x.x.x`.
* В поле `Release notes` копирует все что относится к текущему релизу из файла `CHANGELOG.md`.

## env & Vault

Если в рамках одной из задач были внесены изменения в файл `.env`, то необходимо указывать это в комментарии к задаче, а так же предупреждать тестировщиков перед релизом.

Переменные из `.env`, должны быть перенесены в Vault.

Доступы к Vault можно найти в [wiki](https://wiki.aeroidea.ru/doc/dostupy-k-ploshadkam-HozSFhTgT4)
