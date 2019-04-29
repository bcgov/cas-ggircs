set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(12);

-- Test table raw_report exists in schema ggircs_swrs
select has_table('ggircs_swrs', 'raw_report', 'Table raw_report exists');

-- Test column names in table raw_report are correct
select has_column('ggircs_swrs', 'raw_report', 'id', 'Table has column: id');
select has_column('ggircs_swrs', 'raw_report', 'xml_file', 'Table has column: xml_file');
select has_column('ggircs_swrs', 'raw_report', 'imported_at', 'Table has column: imported_at');

-- Test column id is the Primary Key
select col_is_pk('ggircs_swrs', 'raw_report', 'id', 'Column id is Primary Key');

-- Test columns have correct types
select col_type_is('ggircs_swrs', 'raw_report', 'id', 'integer', 'Column id has type integer');
select col_type_is('ggircs_swrs', 'raw_report', 'xml_file', 'xml', 'Column xml_file has type xml');
select col_type_is('ggircs_swrs', 'raw_report', 'imported_at', 'timestamp with time zone', 'Column imported_at has type timestamp with timezone');

-- Test NOT NULL columns have constraint
select col_not_null('ggircs_swrs', 'raw_report', 'xml_file', 'Column xml_file has NOT NULL constraint');
select col_not_null('ggircs_swrs', 'raw_report', 'imported_at', 'Column imported_at has NOT NULL constraint');

-- Test default columns have default
select col_has_default('ggircs_swrs', 'raw_report', 'imported_at', 'Column imported_at has default');

-- Test default columns have correct default value
select col_default_is('ggircs_swrs', 'raw_report', 'imported_at', 'now()', 'Column imported_at defaults to now()');

select finish();
rollback;
