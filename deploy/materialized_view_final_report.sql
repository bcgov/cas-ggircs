-- Deploy ggircs:materialized_view_final_report to pg
-- requires: materialized_view_facility

begin;

create materialized view ggircs_private.authoritative_report as (
  with authoritative_report as (
    with x as (
      select report.swrs_report_id,
             min(swrs_report_history_id) as swrs_auth_history_id
      from report
      where status = 'Submitted'
      group by swrs_report_id
    )
    select report.*
    from report
           inner join x
                      on report.swrs_report_id = x.swrs_report_id
                        and report.swrs_report_history_id = x.swrs_auth_history_id
  ),
  naics_grouped as (
    select facility_id,
           string_agg(naics_code,',') as naics_code,
           string_agg(naics_classification,',') as naics_classification
    from naics
    group by facility_id
  ),
  report_facility as (
    select
           --*,
           report.id as report_id,
           report.source_xml,
           report.swrs_report_id,
           report.swrs_report_history_id,
           report.report_type,
           report.status as report_status,
           report.submission_date,
           report.reporting_period_duration,
           facility.id as facility_id,
           facility.swrs_facility_id,
           facility.name as facility_name,
           facility.facility_type,
           facility.relationship_type,
           facility.status as facility_status,
           facility.latitude,
           facility.longitude,
           facility.portability_indicator,
           naics_grouped.naics_classification as naics_classification,
           naics_grouped.naics_code           as naics_code,
           identifier_value           as bcghgid
    from authoritative_report as report
    left outer join facility on report.id = facility.report_id
    left outer join naics_grouped on facility.id = naics_grouped.facility_id
    left outer join identifier on identifier.facility_id = facility.id and identifier_type = 'BCGHGID'
    left outer join organisation on organisation.report_id = report.id
    where report.status = 'Submitted'
    order by report.swrs_report_id desc, report.swrs_report_history_id asc
  )
  select * from report_facility
 -- select count(report_id), count(distinct report_id) from report_facility
);

create unique index ggircs_authoritative_report_primary_key on ggircs_private.authoritative_report (report_id);


commit;
