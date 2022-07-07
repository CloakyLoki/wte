CREATE DATABASE where_to_eat;
CREATE SCHEMA default_schema;

CREATE TABLE IF NOT EXISTS roles
(
    id   SERIAL PRIMARY KEY,
    role VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS users
(
    id       SERIAL PRIMARY KEY,
    nickname VARCHAR(128) NOT NULL,
    role     INT REFERENCES roles(id),
    email    VARCHAR(128) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS restaurant
(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(128)              NOT NULL,
    creator INT REFERENCES users (id) NOT NULL
);

CREATE TABLE IF NOT EXISTS rest_location
(
    rest_id     INT REFERENCES restaurant (id) PRIMARY KEY,
    address     VARCHAR(256) NOT NULL,
    city        VARCHAR(128) NOT NULL,
    coordinates point --optional field, not sure
);

CREATE TABLE IF NOT EXISTS rest_open_hours
(
    id           INT REFERENCES restaurant (id) PRIMARY KEY,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL
);

CREATE TABLE IF NOT EXISTS rest_rating
(
    rest_id     INT REFERENCES restaurant (id) PRIMARY KEY,
    rest_rating INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS user_rating
(
    user_id     INT REFERENCES users (id) PRIMARY KEY,
    user_rating INT DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS comments
(
    comment_id SERIAL PRIMARY KEY,
    user_id    INT REFERENCES users (id)      NOT NULL,
    rest_id    INT REFERENCES restaurant (id) NOT NULL,
    comment    TEXT --or VARCHAR is preferable to use?
);

--list of restaurants
CREATE TABLE IF NOT EXISTS rest_list
(
    id   SERIAL PRIMARY KEY,
    rest INT REFERENCES restaurant (id)
);

--link from user to the list of restaurants (for instance, "Travel to Minsk",
-- "Travel to Moscow" or "Favourites"
CREATE TABLE IF NOT EXISTS user_rest_list
(
    id      INT REFERENCES rest_list (id) PRIMARY KEY,
    name    VARCHAR(128) NOT NULL UNIQUE, --name of the list
    user_id INT REFERENCES users (id)
);