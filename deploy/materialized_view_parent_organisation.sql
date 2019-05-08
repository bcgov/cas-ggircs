-- Deploy ggircs:materialized_view_parent_organisation to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.parent_organisation as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by ghgr_import_id asc
  )
  select ghgr_import_id, contact_details.*
  from x,
       xmltable(
           '//parent_organisation'
           passing source_xml
           columns

         ) as parent_organisation
) with no data;

create unique index ggircs_parent_organisation_primary_key
    on ggircs_swrs.parent_organisation (ghgr_import_id);

comment on materialized view ggircs_swrs.parent_organisation is 'The materialized view housing parent organisation information';
comment on column ggircs_swrs.parent_organisation.ghgr_import_id is 'The foreign key reference to ggircs_swrs.ghgr_import';

commit;

