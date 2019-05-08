set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

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
    'facility_id'::name,
    'contact_idx'::name,
    'contact_type'::name,
    'given_name'::name,
    'telephone_number'::name,
    'email_address'::name,
    'position'::name
]);


refresh materialized view ggircs_swrs.contact with data;



select * from finish();
rollback;
