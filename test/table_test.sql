set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(3);

/** Check table compliance **/

-- Tables [table1, table2...] exist in Schema ggircs
select tables_are('ggircs', array ['test']);

-- Schema ggircs should have descriptions for all tables
select matches(
           obj_description('ggircs.test'::regclass, 'pg_class'),
           '.+',
           'Table raw_report has a description'
         );

-- TODO: Enforce table naming conventions
        -- Names are lower-case with underscores_as_word_separators
        -- Names are singular
        -- Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words

-- All tables must have a unique primary key
select has_pk(
          'ggircs', 'test', 'Table has Primary key'
        );

-- TODO: Related tables must have foreign key constraints
        -- FK column names must match PK name from parent

select * from finish();

rollback;
