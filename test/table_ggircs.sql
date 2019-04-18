set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

-- select plan();

/** Check table compliance **/

-- TODO: Schema ggircs should have descriptions for all tables

-- TODO: Enforce table naming conventions
        -- Names are lower-case with underscores_as_word_separators
        -- Names are singular
        -- Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words

-- TODO: All tables must have a unique primary key

-- TODO: Related tables must have foreign key constraints
        -- FK column names must match PK name from parent

rollback;
