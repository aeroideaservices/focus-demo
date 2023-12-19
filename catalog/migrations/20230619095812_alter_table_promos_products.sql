-- +goose Up
-- +goose StatementBegin
ALTER TABLE promos_products
    ADD COLUMN sort BIGINT NOT NULL DEFAULT 0;
ALTER TABLE promos
    ALTER COLUMN sort TYPE BIGINT;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE promos_products
    DROP COLUMN sort;
ALTER TABLE promos
    ALTER COLUMN sort TYPE INTEGER;
-- +goose StatementEnd
