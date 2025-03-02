CREATE TABLE users(
    id bigserial PRIMARY KEY
    ,username varchar(50) NOT NULL UNIQUE
    ,email varchar(255) NOT NULL
    ,password varchar(72) NOT NULL
    ,activated boolean NOT NULL DEFAULT 'false'
    ,created_at timestamp NOT NULL DEFAULT current_timestamp
    ,updated_at timestamp NOT NULL DEFAULT current_timestamp
);