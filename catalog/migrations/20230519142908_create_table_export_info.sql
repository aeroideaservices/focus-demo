-- +goose Up
-- +goose StatementBegin
CREATE TABLE model_export_info
(
    id         UUID NOT NULL PRIMARY KEY,
    model_code TEXT,
    filepath   TEXT,
    status     VARCHAR(50),
    time       TIMESTAMP WITH TIME ZONE
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE model_export_info;
-- +goose StatementEnd
