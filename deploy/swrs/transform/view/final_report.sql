-- Deploy ggircs:materialized_view_final_report to pg
-- requires: materialized_view_facility

begin;

create view swrs_transform.final_report as (
    with _report as (
    select *,
           row_number() over (
             partition by swrs_facility_id, reporting_period_duration
             order by
               swrs_report_id desc,
               submission_date desc,
               imported_at desc
               ) as _history_id
    from swrs_transform.report
    where submission_date is not null
      and report_type != 'SaleClosePurchase'
    and ghgr_import_id not in (select report.ghgr_import_id
                       from swrs_transform.ignore_organisation
                       join swrs_transform.report on ignore_organisation.swrs_organisation_id = report.swrs_organisation_id)
    order by swrs_report_id
  )
  select row_number() over () as id, swrs_report_id, ghgr_import_id
  from _report
  where _history_id = 1
  order by swrs_report_id asc
);

--create unique index ggircs_final_report_primary_key on swrs_transform.final_report (swrs_report_id, ghgr_import_id);

comment on view swrs_transform.final_report is 'The view showing the latest submitted report by swrs_transform.report.id';
comment on column swrs_transform.final_report.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.final_report.swrs_report_id is 'The foreign key referencing swrs_transform.report.id';
comment on column swrs_transform.final_report.ghgr_import_id is 'The foreign key referencing swrs_extract.ghgr_import.id';

commit;


