-- +goose Up
-- +goose StatementBegin
ALTER TABLE menu_items
    ADD COLUMN domain_id UUID
        CONSTRAINT fk_menu_items_domain_id REFERENCES domains ON DELETE CASCADE;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE menu_items
    DROP COLUMN domain_id;
-- +goose StatementEnd
