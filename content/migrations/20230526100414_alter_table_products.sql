-- +goose Up
-- +goose StatementBegin
ALTER TABLE products
    ADD COLUMN colors text[];
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE products
    DROP COLUMN colors;
-- +goose StatementEnd
