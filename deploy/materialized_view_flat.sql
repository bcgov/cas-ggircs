-- Deploy ggircs:materialized_view_flat to pg
-- requires: materialized_view_report

begin;

create materialized view ggircs_swrs.flat as (
  with x as (
    select id,
           report_id,
           xpath('//*[./text()[normalize-space(.)]/parent::* or ./@*]', xml_file) as tag
    from ggircs_swrs.ghgr_import
           inner join ggircs_swrs.report
                      on report.ghgr_import_id = ghgr_import.id
    where report.history_id = 1
  )
  select x.report_id,
         element_id,
         (xpath('name(/*)', node))[1]::text        as class,
         (xpath('name(/*/@*)', node))[1]::text     as attr,
         (xpath('/*/text()|/*/@*', node))[1]::text as value
  from x,
       unnest(x.tag)
         with ordinality as t(node, element_id)
  order by report_id desc, element_id asc
);
create unique index ggircs_flat_primary_key on ggircs_swrs.flat (report_id, element_id);
create index ggircs_flat_report on ggircs_swrs.flat (report_id);

commit;
