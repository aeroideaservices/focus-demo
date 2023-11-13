-- +goose Up
-- +goose StatementBegin
CREATE TABLE forms
(
    id                 UUID NOT NULL PRIMARY KEY,
    name               TEXT,
    code               TEXT,
    save_button_name   TEXT,
    description        TEXT,
    mail_templates_ids UUID[]
);

CREATE TABLE form_fields
(
    id                       UUID NOT NULL PRIMARY KEY,
    name                     TEXT,
    code                     TEXT,
    active                   BOOLEAN,
    required                 BOOLEAN,
    sort                     BIGINT,
    type                     TEXT,
    is_filterable            BOOLEAN,
    is_shown_in_results_list BOOLEAN,
    select_values            TEXT[],
    form_id                  UUID
        CONSTRAINT fk_form_fields_form REFERENCES forms ON DELETE CASCADE
);

CREATE TABLE form_results
(
    id      UUID NOT NULL PRIMARY KEY,
    form_id UUID
        CONSTRAINT fk_form_results_form REFERENCES forms ON DELETE CASCADE
);

CREATE TABLE form_field_values
(
    id             UUID NOT NULL PRIMARY KEY,
    form_field_id  UUID
        CONSTRAINT fk_form_field_values_form_field REFERENCES form_fields ON DELETE CASCADE,
    form_result_id UUID
        CONSTRAINT fk_form_results_field_values REFERENCES form_results ON DELETE CASCADE,
    values         TEXT[]
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE form_field_values;
DROP TABLE form_results;
DROP TABLE form_fields;
DROP TABLE forms;
-- +goose StatementEnd
