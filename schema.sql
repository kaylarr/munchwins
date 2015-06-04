DROP TABLE IF EXISTS users, characters, genders;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(25),
  login VARCHAR(255)
);

CREATE TABLE characters(
  id SERIAL PRIMARY KEY,
  name VARCHAR(15),
  gender_id INT
);

CREATE TABLE genders (
  id SERIAL PRIMARY KEY,
  gender VARCHAR(6)
);

INSERT INTO genders (gender) VALUES ('male');
INSERT INTO genders (gender) VALUES ('female');