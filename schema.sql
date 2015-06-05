DROP TABLE IF EXISTS
  games,
  users,
  characters,
  genders,
  statuses;

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
  game_id INT,                  -- INCORPORATE NOT NULL
  name VARCHAR(15) NOT NULL,
  level INT NOT NULL,
  gender_id INT NOT NULL
);

CREATE TABLE genders (
  id SERIAL PRIMARY KEY,
  gender VARCHAR(6)
);

CREATE TABLE statuses (
  id SERIAL PRIMARY KEY,
  status varchar(15)
);

INSERT INTO genders (gender) VALUES ('male');
INSERT INTO genders (gender) VALUES ('female');
INSERT INTO statuses (status) VALUES ('sex-changed');
INSERT INTO statuses (status) VALUES ('paranoid');

-- Temporary INSERTS for testing

INSERT INTO characters (game_id, name, level, gender_id)
VALUES (1, 'Vin Cheesel', 1, 1);

INSERT INTO characters (game_id, name, level, gender_id)
VALUES (1, 'Swindlerella', 1, 2);

INSERT INTO characters (game_id, name, level, gender_id)
VALUES (1, 'Gingebinge', 1, 1);
