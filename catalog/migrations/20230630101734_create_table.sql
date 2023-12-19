-- +goose Up
-- +goose StatementBegin
ALTER TABLE promos
    ADD COLUMN uint                BIGINT,
    ADD COLUMN float               NUMERIC,
    ADD COLUMN info_email          TEXT,
    ADD COLUMN info_phone          TEXT,
    ADD COLUMN rating              INTEGER,
    ADD COLUMN date                DATE,
    ADD COLUMN short_description   TEXT,
    ADD COLUMN preview_description TEXT
;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE promos
    DROP COLUMN uint,
    DROP COLUMN float,
    DROP COLUMN info_email,
    DROP COLUMN info_phone,
    DROP COLUMN rating,
    DROP COLUMN date,
    DROP COLUMN short_description,
    DROP COLUMN preview_description;
-- +goose StatementEnd
