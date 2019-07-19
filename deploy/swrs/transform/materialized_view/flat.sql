-- Deploy ggircs:materialized_view_flat to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs_transform.flat as (
  select row_number() over () as id, id as ghgr_import_id,
         row_number() over (
           partition by id
           order by
             id desc,
             imported_at desc
           ) as element_id,
         report_flat.*
  from ggircs_swrs_extract.ghgr_import,
       xmltable(
           '//*[./text()[normalize-space(.)] | ./@*[not(name()="xsi:nil") and not(text()="true")]]'
           passing xml_file
           columns
             swrs_report_id numeric(1000,0) path '//ReportID[normalize-space(.)]' not null,
             class varchar(10000) path 'name(.)' not null,
             attr varchar(10000) path 'name(./@*[1])',
             value varchar(10000) path 'concat(./text()[normalize-space(.)], ./@*[1])' not null,
             context varchar(10000) path 'concat( (./ancestor::*/@*)[1], "/", (./ancestor::*/@*)[2], "/", (./ancestor::*/@*)[3] )' not null
         ) as report_flat
  order by id desc, element_id asc
) with no data;
create unique index ggircs_flat_primary_key on ggircs_swrs_transform.flat (ghgr_import_id, element_id);
create index ggircs_flat_report on ggircs_swrs_transform.flat (ghgr_import_id);

comment on materialized view ggircs_swrs_transform.flat is 'The flat view of data in the swrs report';
comment on column ggircs_swrs_transform.flat.id is 'A generated index used for keying in the ggircs schema';
comment on column ggircs_swrs_transform.flat.ghgr_import_id is 'The foreign key reference to ggircs_swrs_extract.ghgr_import.id';
comment on column ggircs_swrs_transform.flat.swrs_report_id is 'The external ReportID as defined by SWRS';
comment on column ggircs_swrs_transform.flat.element_id is 'The assigned element id';
comment on column ggircs_swrs_transform.flat.class is 'The xml class';
comment on column ggircs_swrs_transform.flat.attr is 'The xml attribute';
comment on column ggircs_swrs_transform.flat.value is 'The value of either the xml attribute or the xml body text';
comment on column ggircs_swrs_transform.flat.context is 'The concatenated parent attribute context values';

commit;
