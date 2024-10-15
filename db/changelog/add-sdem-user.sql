-- liquibase formatted sql

-- changeset neil.bottomley:1728900798628-105
CREATE USER '${db_user_sdem_username}' IDENTIFIED BY 'password' PASSWORD EXPIRE;
GRANT SELECT, INSERT, UPDATE, DELETE ON soccer_data.* TO '${db_user_sdem_username}';
SET PASSWORD FOR '${db_user_sdem_username}' = '${db_user_sdem_password}';