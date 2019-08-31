DROP TABLE fixtures;
DROP TABLE teams;

CREATE TABLE teams (
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  played INT4,
  won INT4,
  lost INT4,
  points INT4
);

CREATE TABLE fixtures (
  id SERIAL8 primary key,
  team_a_id INT8 REFERENCES teams(id),
  team_b_id INT8 REFERENCES teams(id),
  winning_team_id INT8 REFERENCES teams(id),
  losing_team_id INT8 REFERENCES teams(id)
);
