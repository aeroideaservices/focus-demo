-- +goose Up
-- +goose StatementBegin
CREATE TABLE promos
(
    id                    UUID      NOT NULL PRIMARY KEY,
    title                 VARCHAR   NOT NULL,
    code                  VARCHAR   NOT NULL,
    image_id              UUID
        CONSTRAINT fk_promos_image REFERENCES media ON DELETE SET NULL,
    active                BOOLEAN   NOT NULL,
    active_from           TIMESTAMP NOT NULL,
    active_to             TIMESTAMP NOT NULL,
    redirect_link         VARCHAR,
    included_kladr_ids    TEXT[],
    sort                  INTEGER DEFAULT 500,
    filtered_catalog_link VARCHAR,
    category_id           UUID
        CONSTRAINT fk_promos_category REFERENCES categories ON DELETE SET NULL,
    description           TEXT
);

CREATE TABLE promos_products
(
    promo_id   UUID NOT NULL
        CONSTRAINT fk_promos_products_promos REFERENCES promos ON DELETE CASCADE,
    product_id UUID NOT NULL
        CONSTRAINT fk_promos_products_products REFERENCES products ON DELETE CASCADE,
    PRIMARY KEY (promo_id, product_id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE promos_products;
DROP TABLE promos;
-- +goose StatementEnd
