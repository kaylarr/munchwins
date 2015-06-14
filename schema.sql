DROP TABLE IF EXISTS
  users,
  games,
  game_states,
  players,
  genders;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  uid VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  game_date DATE NOT NULL,
  user_id INT NOT NULL,
  game_state_id INT NOT NULL
  -- logs TEXT
);

CREATE TABLE game_states (
  id SERIAL PRIMARY KEY,
  state VARCHAR(15)
);

CREATE TABLE players (
  id SERIAL PRIMARY KEY,
  game_id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  level INT NOT NULL,
  gender_id INT NOT NULL,
  in_combat BOOLEAN NOT NULL
);


CREATE TABLE genders (
  id SERIAL PRIMARY KEY,
  gender VARCHAR(6)
);

-- INITIAL TABLE SETUP

INSERT INTO game_states (state) VALUES ('start');
INSERT INTO game_states (state) VALUES ('scores');
INSERT INTO game_states (state) VALUES ('combat');
INSERT INTO game_states (state) VALUES ('finished');

INSERT INTO genders (gender) VALUES ('male');
INSERT INTO genders (gender) VALUES ('female');

-- --------------------------------------------------------------
-- TEMPORARY TEST INSERTS

-- INSERT INTO players (game_id, name, level, gender_id, in_combat)
-- VALUES (1, 'Vin Cheesel', 1, 1, FALSE);

-- INSERT INTO players (game_id, name, level, gender_id, in_combat)
-- VALUES (1, 'Swindlerella', 1, 2, FALSE);

-- INSERT INTO players (game_id, name, level, gender_id, in_combat)
-- VALUES (1, 'Gingebinge', 1, 1, FALSE);

-- INSERT INTO games (game_date, user_id, game_state_id)
-- VALUES ('2015-06-06', 1, 4);

-- INSERT INTO games (game_date, user_id, game_state_id)
-- VALUES ('2015-06-08', 1, 1);
