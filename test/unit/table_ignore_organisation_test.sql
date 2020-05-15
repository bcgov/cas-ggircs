set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(6);

-- Test table eccc_xml_file exists in schema swrs_transform
select has_table('swrs_transform', 'ignore_organisation', 'Table ignore_organisation exists');

-- Test column names in table eccc_xml_file are correct
select columns_are('swrs_transform'::name, 'ignore_organisation'::name, ARRAY[
  'swrs_organisation_id'::name
]);

-- Test column id is the Primary Key
select col_is_pk('swrs_transform', 'ignore_organisation', 'swrs_organisation_id', 'Column swrs_organisation_id is Primary Key');

-- Test columns have correct types
select col_type_is('swrs_transform', 'ignore_organisation', 'swrs_organisation_id', 'integer', 'Column swrs_organisation_id has type integer');

-- Test NOT NULL columns have constraint
select col_not_null('swrs_transform', 'ignore_organisation', 'swrs_organisation_id', 'Column swrs_organisation_id has NOT NULL constraint');

-- Test default columns have default
select col_hasnt_default('swrs_transform', 'ignore_organisation', 'swrs_organisation_id', 'Column swrs_organisation_id has default');

select finish();
rollback;
