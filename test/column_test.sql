set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(4);

/** Check Column Compliance **/

-- DB should have descriptions for all columns
-- TODO: Automate to test on all tables in schema ggircs
select matches(
           col_description('ggircs.test'::regclass::oid, pos),
           '.+',
           'Column has a description'
         ) FROM (VALUES(1),(2),(3)) F(pos);

-- Columns must have defined maximums for CHAR columns
-- TODO: Automate to test all tables in schema, check veracity of 'select 0' comparison
prepare coltype as select columns.character_maximum_length from information_schema.columns where table_schema = 'ggircs' and table_name = 'test' and data_type like 'char%';
select bag_hasnt(
           'coltype', 'select 0', 'columns have defined maximums'
        );

-- TODO: Columns must have defined Scale and Precision for NUMERIC columns

-- TODO: Columns must be defined by an accepted data type

-- TODO: Enforce column naming conventions
        -- Names are lower-case with underscores_as_word_separators
        -- Names are singular
        -- Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words

rollback;
