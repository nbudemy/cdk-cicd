-- liquibase formatted sql

-- changeset neil.bottomley:1728900798628-104
CREATE USER '${db_user_sdapi_username}' IDENTIFIED BY 'password' PASSWORD EXPIRE;
GRANT SELECT ON soccer_data.* TO '${db_user_sdapi_username}';
SET PASSWORD FOR '${db_user_sdapi_username}' = '${db_user_sdapi_password}';