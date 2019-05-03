-- Deploy ggircs:materialized_view_flat to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.flat as (
  with x as (
    select
           ghgr_import.id as ghgr_import_id,
           ghgr_import.xml_file as source_xml,
           ghgr_import.imported_at
    from ggircs_swrs.ghgr_import
    order by ghgr_import_id desc
  )
  select ghgr_import_id,
         row_number() over (
           partition by ghgr_import_id
           order by
             ghgr_import_id desc,
             imported_at desc
           ) as element_id,
         report_flat.class,
         report_flat.attr,
         coalesce(report_flat.attr_value, report_flat.text_value) as value,
         report_flat.context::text::varchar(1000)
  from x,
       xmltable(
           '//*[./text()[normalize-space(.)]/parent::* or ./@*[not(name()="xsi:nil") and not(text()="true")]]'
           passing source_xml
           columns
             class varchar(1000) not null path 'name(.)',
             attr varchar(1000) not null path 'name(./@*)',
             attr_value varchar(1000) path './@*',
             text_value varchar(1000) path 'string(./text())',
             context xml path './ancestor::*/@*'
         ) as report_flat
  order by ghgr_import_id desc, element_id asc
) with no data;
create unique index ggircs_flat_primary_key on ggircs_swrs.flat (ghgr_import_id, element_id);
create index ggircs_flat_report on ggircs_swrs.flat (ghgr_import_id);

comment on materialized view ggircs_swrs.flat is 'The flat view of data in the swrs report';
comment on column ggircs_swrs.flat.ghgr_import_id is 'The internal ghgr_import id';
comment on column ggircs_swrs.flat.element_id is 'The assigned element id';
comment on column ggircs_swrs.flat.class is 'The xml class';
comment on column ggircs_swrs.flat.attr is 'The xml attribute';
comment on column ggircs_swrs.flat.value is 'The value of either the xml attribute or the xml body text';
comment on column ggircs_swrs.flat.context is 'The concatenated parent attribute context values';

commit;
