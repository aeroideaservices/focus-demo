-- +goose Up
-- +goose StatementBegin
CREATE TABLE mail_templates
(
    id         UUID NOT NULL PRIMARY KEY,
    subject    TEXT,
    sender     TEXT,
    recipients TEXT[],
    template   TEXT
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE mail_templates;
-- +goose StatementEnd
