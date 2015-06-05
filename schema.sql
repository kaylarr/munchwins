DROP TABLE IF EXISTS games, users, characters, genders;

CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  game_date DATE NOT NULL,
  user_id INT NOT NULL,
  logs TEXT
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(25) NOT NULL,
  login VARCHAR(255) NOT NULL
);

CREATE TABLE characters (
  id SERIAL PRIMARY KEY,
  game_id INT NOT NULL,
  name VARCHAR(15) NOT NULL,
  level INT NOT NULL,
  gender_id INT NOT NULL
);

CREATE TABLE genders (
  id SERIAL PRIMARY KEY,
  gender VARCHAR(6)
);

INSERT INTO genders (gender) VALUES ('male');
INSERT INTO genders (gender) VALUES ('female');