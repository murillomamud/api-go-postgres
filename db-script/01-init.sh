#!/bin/bash
set -e
export PGPASSWORD=1234;
psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-EOSQL
    create database api_todo;
    create user user_todo;
    alter user user_todo with encrypted password '1122';
    grant all privileges on database api_todo to user_todo;
    \c api_todo
  BEGIN;
    create table if not exists todos (id serial primary key, title varchar, description text, done bool default false);
  COMMIT;
    grant all privileges on all tables in schema public to user_todo;
    grant all privileges on all sequences in schema public to user_todo;
EOSQL