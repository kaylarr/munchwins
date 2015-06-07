DROP TABLE IF EXISTS
  games,
  users,
  characters,
  genders,
  statuses;

CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  --game_date DATE NOT NULL,
  state_id INT NOT NULL,
  user_id INT, -- NOT NULL
  logs TEXT
);

CREATE TABLE game_states (
  id SERIAL PRIMARY KEY,
  state VARCHAR(50)
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  login VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE characters (
  id SERIAL PRIMARY KEY,
  game_id INT, -- NOT NULL
  name VARCHAR(50) NOT NULL,
  level INT NOT NULL,
  gender_id INT NOT NULL
);

CREATE TABLE genders (
  id SERIAL PRIMARY KEY,
  gender VARCHAR(6)
);

-- CREATE TABLE statuses (
--   id SERIAL PRIMARY KEY,
--   status varchar(50)
-- );

-- INITIAL TABLE SETUP

INSERT INTO game_states (state) VALUES ('start');
INSERT INTO game_states (state) VALUES ('cards');
INSERT INTO game_states (state) VALUES ('combat');
INSERT INTO game_states (state) VALUES ('finished');

INSERT INTO genders (gender) VALUES ('male');
INSERT INTO genders (gender) VALUES ('female');

-- INSERT INTO statuses (status) VALUES ('sex-changed');
-- INSERT INTO statuses (status) VALUES ('paranoid');

-- TEMPORARY TEST INSERTS

INSERT INTO characters (game_id, name, level, gender_id)
VALUES (1, 'Vin Cheesel', 1, 1);

INSERT INTO characters (game_id, name, level, gender_id)
VALUES (1, 'Swindlerella', 1, 2);

INSERT INTO characters (game_id, name, level, gender_id)
VALUES (1, 'Gingebinge', 1, 1);

INSERT INTO games (game_date, state_id, user_id)
VALUES ('2015-06-06', 1, 1);

INSERT INTO users (first_name, login)
VALUES ('kevin', 'thisismylogin');