-- +goose Up
-- +goose StatementBegin
CREATE TABLE menus
(
    id   UUID NOT NULL PRIMARY KEY,
    code TEXT,
    name TEXT
);

CREATE TABLE menu_items
(
    id                  UUID NOT NULL PRIMARY KEY,
    name                TEXT,
    url                 TEXT,
    position            BIGINT,
    additional_fields   JSONB,
    parent_menu_item_id UUID
        CONSTRAINT fk_menu_items_parent_menu_item REFERENCES menu_items ON DELETE CASCADE,
    menu_id             UUID
        CONSTRAINT fk_menu_items_menu REFERENCES menus ON DELETE CASCADE
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE menu_items;
DROP TABLE menus;
-- +goose StatementEnd
