set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(1);

create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;
create table csv_import_fixture (csv_column_fixture text);
\set csv_import_fixture_file :CURRENT_DIR '/test/fixture/csv_import_fixture.csv'
copy csv_import_fixture from :'csv_import_fixture_file' delimiter ',' csv;
select set_eq(
    'select * from csv_import_fixture',
    array[ 'value exists' ]
);

select * from finish();

rollback;

