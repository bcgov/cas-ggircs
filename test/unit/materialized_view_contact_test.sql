set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(29);

select has_materialized_view(
    'ggircs_swrs', 'contact',
    'ggircs_swrs.contact should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'contact', 'ggircs_contact_primary_key',
    'ggircs_swrs.contact should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'contact'::name, array[
    'ghgr_import_id'::name,
    'path_context'::name,
    'swrs_facility_id'::name,
    'contact_idx'::name,
    'contact_type'::name,
    'given_name'::name,
    'telephone_number'::name,
    'email_address'::name,
    'position'::name
]);

select col_type_is(      'ggircs_swrs', 'contact', 'ghgr_import_id', 'integer', 'contact.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'contact', 'ghgr_import_id', 'contact.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'contact', 'path_context', 'contact.path_context column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'path_context', 'character varying(1000)', 'contact.path_context column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'path_context', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'path_context', 'contact.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'swrs_facility_id', 'contact.facility_id column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'swrs_facility_id', 'numeric(1000,0)', 'contact.swrs_facility_id column should be type numeric');
select col_is_null(      'ggircs_swrs', 'contact', 'swrs_facility_id', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'swrs_facility_id', 'contact.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'contact_idx', 'contact.contact_idx column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'contact_idx', 'integer', 'contact.contact_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'contact', 'contact_idx', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'contact_idx', 'contact.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'contact_type', 'contact.contact_type column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'contact_type', 'character varying(1000)', 'contact.contact_type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'contact_type', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'contact_type', 'contact.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'given_name', 'contact.given_name column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'given_name', 'character varying(1000)', 'contact.given_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'given_name', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'given_name', 'contact.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'telephone_number', 'contact.telephone_number column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'telephone_number', 'character varying(1000)', 'contact.telephone_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'telephone_number', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'telephone_number', 'contact.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'email_address', 'contact.email_address column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'email_address', 'character varying(1000)', 'contact.email_address column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'email_address', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'email_address', 'contact.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'position', 'contact.position column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'position', 'character varying(1000)', 'contact.position column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'position', 'contact.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'position', 'contact.activity_idx column should not have a default');

refresh materialized view ggircs_swrs.contact with data;

-- TODO: Add a fixture to test the veracity of what is being pulled in to this view from xml

select * from finish();
rollback;
