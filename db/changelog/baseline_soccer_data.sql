-- liquibase formatted sql

-- changeset neil.bottomley:1728900798628-1
CREATE TABLE area (area_id BINARY(16) NOT NULL, area_name VARCHAR(200) NOT NULL, area_code VARCHAR(3) NULL, area_opta_id VARCHAR(30) NULL, CONSTRAINT PK_AREA PRIMARY KEY (area_id));

-- changeset neil.bottomley:1728900798628-2
CREATE TABLE canonicalised_competition (canonicalised_competition_id INT UNSIGNED AUTO_INCREMENT NOT NULL, supplier_id INT UNSIGNED NOT NULL, supplier_competition_id VARCHAR(200) NOT NULL, competition_id BINARY(16) NOT NULL, start_date_time datetime DEFAULT '2023-01-01 00:00:00' NOT NULL, CONSTRAINT PK_CANONICALISED_COMPETITION PRIMARY KEY (canonicalised_competition_id));

-- changeset neil.bottomley:1728900798628-3
CREATE TABLE competition (competition_id BINARY(16) NOT NULL, name VARCHAR(200) NOT NULL, area_id BINARY(16) NOT NULL, supplier_id TINYINT(3) NOT NULL, supplier_competition_id VARCHAR(200) NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_COMPETITION PRIMARY KEY (competition_id));

-- changeset neil.bottomley:1728900798628-4
CREATE TABLE competition_preferences (competition_preferences_id INT UNSIGNED AUTO_INCREMENT NOT NULL, primary_supplier INT UNSIGNED NOT NULL, competition_id BINARY(16) NOT NULL, hours_before_kickoff_to_publish INT UNSIGNED NOT NULL, is_available_in_play BIT(1) NOT NULL, is_available_pre_match BIT(1) NOT NULL, start_date_time datetime DEFAULT '2022-01-01 00:00:00' NOT NULL, player_data_tradable TINYINT(3) DEFAULT 0 NOT NULL, CONSTRAINT PK_COMPETITION_PREFERENCES PRIMARY KEY (competition_preferences_id));

-- changeset neil.bottomley:1728900798628-5
CREATE TABLE fixture (fixture_id BINARY(16) NOT NULL, stage_id BINARY(16) NOT NULL, home_team_id BINARY(16) NOT NULL, away_team_id BINARY(16) NOT NULL, `description` VARCHAR(200) NOT NULL, venue_id BINARY(16) NULL, is_neutral BIT(1) NOT NULL, is_cup BIT(1) NOT NULL, has_extra_time BIT(1) NOT NULL, has_pens BIT(1) NOT NULL, agg_score TINYINT(3) UNSIGNED NOT NULL, start_time datetime NOT NULL, half_duration SMALLINT UNSIGNED DEFAULT 2700 NOT NULL, extra_time_half_duration SMALLINT UNSIGNED DEFAULT 900 NOT NULL, status VARCHAR(50) NOT NULL, coverage VARCHAR(50) NULL, feed_supplier_override INT UNSIGNED NULL, created datetime DEFAULT NOW() NOT NULL, created_by INT UNSIGNED NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, last_updated_by_id INT UNSIGNED NOT NULL, CONSTRAINT PK_FIXTURE PRIMARY KEY (fixture_id));

-- changeset neil.bottomley:1728900798628-6
CREATE TABLE incorrect_player_link (supplier_player_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, player_id BINARY(16) NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_INCORRECT_PLAYER_LINK PRIMARY KEY (supplier_player_id, supplier_id, player_id));

-- changeset neil.bottomley:1728900798628-7
CREATE TABLE player (player_id BINARY(16) NOT NULL, first_name VARCHAR(200) NULL, surname VARCHAR(200) NOT NULL, custom_full_name VARCHAR(200) NULL, match_name VARCHAR(200) NOT NULL, is_active BIT(1) NOT NULL, nationality BINARY(16) NOT NULL, birthday date NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, last_updated_by_id INT UNSIGNED NOT NULL, CONSTRAINT PK_PLAYER PRIMARY KEY (player_id));

-- changeset neil.bottomley:1728900798628-8
CREATE TABLE player_team_tournament (player_id BINARY(16) NOT NULL, team_id BINARY(16) NOT NULL, tournament_id BINARY(16) NOT NULL, shirt_number SMALLINT UNSIGNED NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_PLAYER_TEAM_TOURNAMENT PRIMARY KEY (player_id, team_id, tournament_id));

-- changeset neil.bottomley:1728900798628-9
CREATE TABLE stage (stage_id BINARY(16) NOT NULL, tournament_id BINARY(16) NOT NULL, name VARCHAR(200) NOT NULL, start_date date NOT NULL, end_date date NOT NULL, supplier_id TINYINT(3) NOT NULL, supplier_stage_id VARCHAR(200) NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_STAGE PRIMARY KEY (stage_id));

-- changeset neil.bottomley:1728900798628-10
CREATE TABLE supplier (supplier_id INT UNSIGNED AUTO_INCREMENT NOT NULL, name VARCHAR(200) NOT NULL, is_primary BIT(1) DEFAULT 0 NOT NULL, CONSTRAINT PK_SUPPLIER PRIMARY KEY (supplier_id));

-- changeset neil.bottomley:1728900798628-11
CREATE TABLE supplier_fixture (supplier_fixture_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, fixture_id BINARY(16) NOT NULL, supplier_tournament_id VARCHAR(200) NULL, start_time datetime NOT NULL, supplier_coverage VARCHAR(50) NULL, is_booked BIT(1) DEFAULT 0 NOT NULL, can_be_used_for_trade BIT(1) DEFAULT 1 NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_SUPPLIER_FIXTURE PRIMARY KEY (supplier_fixture_id, supplier_id));

-- changeset neil.bottomley:1728900798628-12
CREATE TABLE supplier_fixture_booking (supplier_fixture_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, is_booked BIT(1) DEFAULT 0 NOT NULL, supplier_competition_id VARCHAR(200) NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_SUPPLIER_FIXTURE_BOOKING PRIMARY KEY (supplier_fixture_id, supplier_id));

-- changeset neil.bottomley:1728900798628-13
CREATE TABLE supplier_player (supplier_player_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, player_id BINARY(16) NOT NULL, first_name VARCHAR(200) NULL, surname VARCHAR(200) NOT NULL, birthday date NULL, is_confirmed BIT(1) DEFAULT 0 NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_SUPPLIER_PLAYER PRIMARY KEY (supplier_player_id, supplier_id));

-- changeset neil.bottomley:1728900798628-14
CREATE TABLE supplier_team (supplier_team_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, team_id BINARY(16) NOT NULL, name VARCHAR(200) NOT NULL, is_confirmed BIT(1) DEFAULT 0 NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_SUPPLIER_TEAM PRIMARY KEY (supplier_team_id, supplier_id));

-- changeset neil.bottomley:1728900798628-15
CREATE TABLE supplier_tournament (supplier_tournament_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, tournament_id BINARY(16) NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_SUPPLIER_TOURNAMENT PRIMARY KEY (supplier_tournament_id, supplier_id, tournament_id));

-- changeset neil.bottomley:1728900798628-16
CREATE TABLE team (team_id BINARY(16) NOT NULL, name VARCHAR(200) NOT NULL, custom_name VARCHAR(200) NULL, code VARCHAR(10) NULL, area_id BINARY(16) NOT NULL, is_national BIT(1) NOT NULL, team_type VARCHAR(30) NOT NULL, home_venue_id BINARY(16) NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, last_updated_by_id INT UNSIGNED NOT NULL, CONSTRAINT PK_TEAM PRIMARY KEY (team_id));

-- changeset neil.bottomley:1728900798628-17
CREATE TABLE tournament (tournament_id BINARY(16) NOT NULL, competition_id BINARY(16) NOT NULL, name VARCHAR(200) NOT NULL, `description` VARCHAR(200) NOT NULL, start_date date NOT NULL, end_date date NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, last_updated_by_id INT UNSIGNED NOT NULL, CONSTRAINT PK_TOURNAMENT PRIMARY KEY (tournament_id));

-- changeset neil.bottomley:1728900798628-18
CREATE TABLE unrelated_fixture (supplier_fixture_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, supplier_tournament_id VARCHAR(200) NOT NULL, supplier_tournament_name VARCHAR(200) NOT NULL, supplier_home_team_id VARCHAR(200) NOT NULL, supplier_home_team_name VARCHAR(200) NOT NULL, supplier_away_team_id VARCHAR(200) NOT NULL, supplier_away_team_name VARCHAR(200) NOT NULL, supplier_start_date_time datetime NOT NULL, related_runningball_fixture_id VARCHAR(200) NULL, related_opta_fixture_uuid VARCHAR(200) NULL, related_opta_legacy_fixture_id VARCHAR(200) NULL, related_opta_competition_uuid VARCHAR(200) NULL, relinking_retries TINYINT(3) DEFAULT 0 NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, related_fixture_supplier_id INT UNSIGNED NULL, related_fixture_supplier_fixture_id VARCHAR(200) NULL, CONSTRAINT PK_UNRELATED_FIXTURE PRIMARY KEY (supplier_fixture_id, supplier_id));

-- changeset neil.bottomley:1728900798628-19
CREATE TABLE unrelated_player (supplier_player_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, supplier_team_id VARCHAR(200) NULL, supplier_first_name VARCHAR(200) NULL, supplier_surname VARCHAR(200) NOT NULL, supplier_shirt_number SMALLINT UNSIGNED NULL, related_opta_player_id VARCHAR(200) NULL, area_id VARCHAR(200) NULL, relinking_retries TINYINT(3) DEFAULT 0 NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, related_player_supplier_id INT UNSIGNED NULL, related_player_supplier_player_id VARCHAR(200) NULL, CONSTRAINT PK_UNRELATED_PLAYER PRIMARY KEY (supplier_player_id, supplier_id));

-- changeset neil.bottomley:1728900798628-20
CREATE TABLE unrelated_team (supplier_team_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, name VARCHAR(200) NOT NULL, related_opta_team_id VARCHAR(200) NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, related_team_supplier_id INT UNSIGNED NULL, related_team_supplier_team_id VARCHAR(200) NULL, CONSTRAINT PK_UNRELATED_TEAM PRIMARY KEY (supplier_team_id, supplier_id));

-- changeset neil.bottomley:1728900798628-21
CREATE TABLE unrelated_tournament (supplier_tournament_id VARCHAR(200) NOT NULL, supplier_id INT UNSIGNED NOT NULL, supplier_tournament_name VARCHAR(200) NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, supplier_start_date datetime NOT NULL, supplier_end_date datetime NOT NULL, related_tournament_supplier_id INT UNSIGNED NULL, related_tournament_supplier_tournament_id VARCHAR(200) NULL, related_competition_supplier_id INT UNSIGNED NULL, related_competition_supplier_competition_id VARCHAR(200) NULL, CONSTRAINT PK_UNRELATED_TOURNAMENT PRIMARY KEY (supplier_tournament_id, supplier_id));

-- changeset neil.bottomley:1728900798628-22
CREATE TABLE venue (venue_id BINARY(16) NOT NULL, name VARCHAR(200) NOT NULL, supplier_id TINYINT(3) NOT NULL, supplier_venue_id VARCHAR(200) NOT NULL, created datetime DEFAULT NOW() NOT NULL, last_updated datetime DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL, CONSTRAINT PK_VENUE PRIMARY KEY (venue_id));

-- changeset neil.bottomley:1728900798628-23
ALTER TABLE canonicalised_competition ADD CONSTRAINT supp_comp_id_supp_id UNIQUE (supplier_competition_id, supplier_id);

-- changeset neil.bottomley:1728900798628-24
ALTER TABLE competition ADD CONSTRAINT supp_comp_id_supp_id UNIQUE (supplier_competition_id, supplier_id);

-- changeset neil.bottomley:1728900798628-25
ALTER TABLE stage ADD CONSTRAINT supp_stage_id_supp_id UNIQUE (supplier_stage_id, supplier_id);

-- changeset neil.bottomley:1728900798628-26
CREATE INDEX area_id ON competition(area_id);

-- changeset neil.bottomley:1728900798628-27
CREATE INDEX area_id ON team(area_id);

-- changeset neil.bottomley:1728900798628-28
CREATE INDEX away_team_id ON fixture(away_team_id);

-- changeset neil.bottomley:1728900798628-29
CREATE INDEX competition_id ON canonicalised_competition(competition_id);

-- changeset neil.bottomley:1728900798628-30
CREATE INDEX competition_id ON competition_preferences(competition_id);

-- changeset neil.bottomley:1728900798628-31
CREATE INDEX competition_id ON tournament(competition_id);

-- changeset neil.bottomley:1728900798628-32
CREATE INDEX created_by ON fixture(created_by);

-- changeset neil.bottomley:1728900798628-33
CREATE INDEX feed_supplier_override ON fixture(feed_supplier_override);

-- changeset neil.bottomley:1728900798628-34
CREATE INDEX fixture_id ON supplier_fixture(fixture_id);

-- changeset neil.bottomley:1728900798628-35
CREATE INDEX home_team_id ON fixture(home_team_id);

-- changeset neil.bottomley:1728900798628-36
CREATE INDEX home_venue_id ON team(home_venue_id);

-- changeset neil.bottomley:1728900798628-37
CREATE INDEX last_updated ON supplier_fixture(last_updated);

-- changeset neil.bottomley:1728900798628-38
CREATE INDEX last_updated_by_id ON fixture(last_updated_by_id);

-- changeset neil.bottomley:1728900798628-39
CREATE INDEX last_updated_by_id ON player(last_updated_by_id);

-- changeset neil.bottomley:1728900798628-40
CREATE INDEX last_updated_by_id ON team(last_updated_by_id);

-- changeset neil.bottomley:1728900798628-41
CREATE INDEX last_updated_by_id ON tournament(last_updated_by_id);

-- changeset neil.bottomley:1728900798628-42
CREATE INDEX nationality ON player(nationality);

-- changeset neil.bottomley:1728900798628-43
CREATE INDEX player_id ON incorrect_player_link(player_id);

-- changeset neil.bottomley:1728900798628-44
CREATE INDEX player_id ON supplier_player(player_id);

-- changeset neil.bottomley:1728900798628-45
CREATE INDEX primary_supplier ON competition_preferences(primary_supplier);

-- changeset neil.bottomley:1728900798628-46
CREATE INDEX related_competition_supplier_id ON unrelated_tournament(related_competition_supplier_id);

-- changeset neil.bottomley:1728900798628-47
CREATE INDEX related_fixture_supplier_id ON unrelated_fixture(related_fixture_supplier_id);

-- changeset neil.bottomley:1728900798628-48
CREATE INDEX related_player_supplier_id ON unrelated_player(related_player_supplier_id);

-- changeset neil.bottomley:1728900798628-49
CREATE INDEX related_team_supplier_id ON unrelated_team(related_team_supplier_id);

-- changeset neil.bottomley:1728900798628-50
CREATE INDEX related_tournament_supplier_id ON unrelated_tournament(related_tournament_supplier_id);

-- changeset neil.bottomley:1728900798628-51
CREATE INDEX stage_id ON fixture(stage_id);

-- changeset neil.bottomley:1728900798628-52
CREATE INDEX start_time ON fixture(start_time);

-- changeset neil.bottomley:1728900798628-53
CREATE INDEX supplier_id ON canonicalised_competition(supplier_id);

-- changeset neil.bottomley:1728900798628-54
CREATE INDEX team_id ON player_team_tournament(team_id);

-- changeset neil.bottomley:1728900798628-55
CREATE INDEX team_id ON supplier_team(team_id);

-- changeset neil.bottomley:1728900798628-56
CREATE INDEX tournament_id ON player_team_tournament(tournament_id);

-- changeset neil.bottomley:1728900798628-57
CREATE INDEX tournament_id ON stage(tournament_id);

-- changeset neil.bottomley:1728900798628-58
CREATE INDEX tournament_id ON supplier_tournament(tournament_id);

-- changeset neil.bottomley:1728900798628-59
CREATE INDEX venue_id ON fixture(venue_id);

-- changeset neil.bottomley:1728900798628-60
ALTER TABLE canonicalised_competition ADD CONSTRAINT canonicalised_competition_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-61
ALTER TABLE canonicalised_competition ADD CONSTRAINT canonicalised_competition_ibfk_2 FOREIGN KEY (competition_id) REFERENCES competition (competition_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-62
ALTER TABLE competition ADD CONSTRAINT competition_ibfk_1 FOREIGN KEY (area_id) REFERENCES area (area_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-63
ALTER TABLE competition_preferences ADD CONSTRAINT competition_preferences_ibfk_1 FOREIGN KEY (primary_supplier) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-64
ALTER TABLE competition_preferences ADD CONSTRAINT competition_preferences_ibfk_2 FOREIGN KEY (competition_id) REFERENCES competition (competition_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-65
ALTER TABLE fixture ADD CONSTRAINT fixture_ibfk_1 FOREIGN KEY (home_team_id) REFERENCES team (team_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-66
ALTER TABLE fixture ADD CONSTRAINT fixture_ibfk_2 FOREIGN KEY (away_team_id) REFERENCES team (team_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-67
ALTER TABLE fixture ADD CONSTRAINT fixture_ibfk_3 FOREIGN KEY (created_by) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-68
ALTER TABLE fixture ADD CONSTRAINT fixture_ibfk_4 FOREIGN KEY (stage_id) REFERENCES stage (stage_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-69
ALTER TABLE fixture ADD CONSTRAINT fixture_ibfk_5 FOREIGN KEY (venue_id) REFERENCES venue (venue_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-70
ALTER TABLE fixture ADD CONSTRAINT fixture_ibfk_6 FOREIGN KEY (last_updated_by_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-71
ALTER TABLE fixture ADD CONSTRAINT fixture_ibfk_7 FOREIGN KEY (feed_supplier_override) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-72
ALTER TABLE incorrect_player_link ADD CONSTRAINT incorrect_player_link_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-73
ALTER TABLE incorrect_player_link ADD CONSTRAINT incorrect_player_link_ibfk_2 FOREIGN KEY (player_id) REFERENCES player (player_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-74
ALTER TABLE player ADD CONSTRAINT player_ibfk_1 FOREIGN KEY (last_updated_by_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-75
ALTER TABLE player ADD CONSTRAINT player_ibfk_2 FOREIGN KEY (nationality) REFERENCES area (area_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-76
ALTER TABLE player_team_tournament ADD CONSTRAINT player_team_tournament_ibfk_1 FOREIGN KEY (player_id) REFERENCES player (player_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-77
ALTER TABLE player_team_tournament ADD CONSTRAINT player_team_tournament_ibfk_2 FOREIGN KEY (team_id) REFERENCES team (team_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-78
ALTER TABLE player_team_tournament ADD CONSTRAINT player_team_tournament_ibfk_3 FOREIGN KEY (tournament_id) REFERENCES tournament (tournament_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-79
ALTER TABLE stage ADD CONSTRAINT stage_ibfk_1 FOREIGN KEY (tournament_id) REFERENCES tournament (tournament_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-80
ALTER TABLE supplier_fixture_booking ADD CONSTRAINT supplier_fixture_booking_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-81
ALTER TABLE supplier_fixture ADD CONSTRAINT supplier_fixture_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-82
ALTER TABLE supplier_fixture ADD CONSTRAINT supplier_fixture_ibfk_2 FOREIGN KEY (fixture_id) REFERENCES fixture (fixture_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-83
ALTER TABLE supplier_player ADD CONSTRAINT supplier_player_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-84
ALTER TABLE supplier_player ADD CONSTRAINT supplier_player_ibfk_2 FOREIGN KEY (player_id) REFERENCES player (player_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-85
ALTER TABLE supplier_team ADD CONSTRAINT supplier_team_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-86
ALTER TABLE supplier_team ADD CONSTRAINT supplier_team_ibfk_2 FOREIGN KEY (team_id) REFERENCES team (team_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-87
ALTER TABLE supplier_tournament ADD CONSTRAINT supplier_tournament_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-88
ALTER TABLE supplier_tournament ADD CONSTRAINT supplier_tournament_ibfk_2 FOREIGN KEY (tournament_id) REFERENCES tournament (tournament_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-89
ALTER TABLE team ADD CONSTRAINT team_ibfk_1 FOREIGN KEY (home_venue_id) REFERENCES venue (venue_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-90
ALTER TABLE team ADD CONSTRAINT team_ibfk_2 FOREIGN KEY (area_id) REFERENCES area (area_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-91
ALTER TABLE team ADD CONSTRAINT team_ibfk_3 FOREIGN KEY (last_updated_by_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-92
ALTER TABLE tournament ADD CONSTRAINT tournament_ibfk_1 FOREIGN KEY (competition_id) REFERENCES competition (competition_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-93
ALTER TABLE tournament ADD CONSTRAINT tournament_ibfk_2 FOREIGN KEY (last_updated_by_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-94
ALTER TABLE unrelated_fixture ADD CONSTRAINT unrelated_fixture_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-95
ALTER TABLE unrelated_fixture ADD CONSTRAINT unrelated_fixture_ibfk_2 FOREIGN KEY (related_fixture_supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-96
ALTER TABLE unrelated_player ADD CONSTRAINT unrelated_player_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-97
ALTER TABLE unrelated_player ADD CONSTRAINT unrelated_player_ibfk_2 FOREIGN KEY (related_player_supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-98
ALTER TABLE unrelated_team ADD CONSTRAINT unrelated_team_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-99
ALTER TABLE unrelated_team ADD CONSTRAINT unrelated_team_ibfk_2 FOREIGN KEY (related_team_supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-100
ALTER TABLE unrelated_tournament ADD CONSTRAINT unrelated_tournament_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-101
ALTER TABLE unrelated_tournament ADD CONSTRAINT unrelated_tournament_ibfk_2 FOREIGN KEY (related_tournament_supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- changeset neil.bottomley:1728900798628-102
ALTER TABLE unrelated_tournament ADD CONSTRAINT unrelated_tournament_ibfk_3 FOREIGN KEY (related_competition_supplier_id) REFERENCES supplier (supplier_id) ON UPDATE RESTRICT ON DELETE RESTRICT;

