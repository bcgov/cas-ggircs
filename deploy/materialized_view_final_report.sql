-- Deploy ggircs:materialized_view_final_report to pg
-- requires: materialized_view_facility

begin;

create materialized view ggircs_swrs.final_report as (
    with _report as (
    select *,
           row_number() over (
             partition by swrs_report_id
             order by
               submission_date desc,
               ghgr_import_id desc
             ) as _history_id
    from ggircs_swrs.report
    where submission_date is not null
    and ghgr_import_id not in (select report.ghgr_import_id
                       from ggircs_swrs.table_ignore_organisation
                       join ggircs_swrs.report on table_ignore_organisation.swrs_organisation_id = report.swrs_organisation_id)
    order by swrs_report_id
  )
  select swrs_report_id, ghgr_import_id
  from _report
  where _history_id = 1
  order by swrs_report_id asc
) with no data;

create unique index ggircs_final_report_primary_key on ggircs_swrs.final_report (swrs_report_id, ghgr_import_id);

comment on materialized view ggircs_swrs.final_report is 'The view showing the latest submitted report by ggircs_swrs.report.id';
comment on column ggircs_swrs.final_report.swrs_report_id is 'The foreign key referencing ggircs_swrs.report.id';
comment on column ggircs_swrs.final_report.ghgr_import_id is 'The foreign key referencing ggircs_swrs.ghgr_import.id';

commit;
