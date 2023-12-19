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

CREATE TABLE stores
(
    id            UUID        NOT NULL PRIMARY KEY,
    name          VARCHAR(50) NOT NULL,
    latitude      NUMERIC     NOT NULL,
    longitude     NUMERIC     NOT NULL,
    contact_email VARCHAR,
    contact_phone VARCHAR(12),
    opening_time  TIME WITHOUT TIME ZONE,
    closing_time  TIME WITHOUT TIME ZONE,
    image_id      UUID
        CONSTRAINT fk_stores_image REFERENCES media ON DELETE SET NULL,
    description   TEXT
);

CREATE TABLE categories
(
    id          UUID    NOT NULL PRIMARY KEY,
    name        VARCHAR NOT NULL,
    code        VARCHAR NOT NULL,
    category_id UUID
        CONSTRAINT fk_categories_category REFERENCES categories ON DELETE CASCADE
);

CREATE TABLE products
(
    id          UUID    NOT NULL PRIMARY KEY,
    name        VARCHAR NOT NULL,
    external_id INT     NOT NULL,
    category_id UUID
        CONSTRAINT fk_products_category REFERENCES categories ON DELETE SET NULL
);

CREATE TABLE stores_products
(
    store_id   UUID NOT NULL
        CONSTRAINT fk_stores_products_stores REFERENCES stores ON UPDATE CASCADE ON DELETE CASCADE,
    product_id UUID NOT NULL
        CONSTRAINT fk_stores_products_products REFERENCES products ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (store_id, product_id)
);

CREATE TABLE products_media
(
    product_id UUID NOT NULL
        CONSTRAINT fk_products_media_products REFERENCES products ON DELETE CASCADE,
    media_id   UUID NOT NULL
        CONSTRAINT fk_products_media_medias REFERENCES media ON DELETE CASCADE,
    PRIMARY KEY (product_id, media_id)
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE products_media;
DROP TABLE stores_products;
DROP TABLE products;
DROP TABLE categories;
DROP TABLE stores;
DROP TABLE media;
DROP TABLE folders;
-- +goose StatementEnd
