-- +goose Up
-- +goose StatementBegin
CREATE TABLE domains
(
    id         UUID NOT NULL PRIMARY KEY,
    domain       VARCHAR
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE domains;
-- +goose StatementEnd
