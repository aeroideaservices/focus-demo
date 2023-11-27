-- +goose Up
-- +goose StatementBegin
CREATE TABLE folders
(
    id         UUID NOT NULL PRIMARY KEY,
    name       VARCHAR,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    folder_id  UUID
        CONSTRAINT fk_folders_folder REFERENCES folders ON DELETE CASCADE
);

CREATE TABLE media
(
    id         UUID NOT NULL PRIMARY KEY,
    name       VARCHAR,
    filename   VARCHAR,
    alt        VARCHAR,
    title      VARCHAR,
    size       BIGINT,
    filepath   TEXT,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    folder_id  UUID
        CONSTRAINT fk_folders_medias REFERENCES folders ON DELETE CASCADE
        CONSTRAINT fk_media_folder REFERENCES folders,
    import_id  VARCHAR,
    source     VARCHAR
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE media;
DROP TABLE folders;
-- +goose StatementEnd
