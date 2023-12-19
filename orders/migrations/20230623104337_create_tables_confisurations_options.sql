-- +goose Up
-- +goose StatementBegin
CREATE TABLE configurations
(
    id         UUID NOT NULL PRIMARY KEY,
    code       TEXT,
    name       TEXT,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE options
(
    id         UUID NOT NULL PRIMARY KEY,
    conf_id    UUID
        CONSTRAINT fk_options_conf REFERENCES configurations ON DELETE CASCADE,
    code       TEXT,
    name       TEXT,
    type       TEXT,
    value      TEXT,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
);

CREATE UNIQUE INDEX idx_conf_id_code
    ON options (conf_id, code);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE options;
DROP TABLE configurations;
-- +goose StatementEnd
