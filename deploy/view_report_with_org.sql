-- Deploy ggircs:view_report_with_org to pg
-- requires: schema_ggircs

begin;

create or replace view ggircs.report_with_org as
select
       _organisation.business_legal_name,
       _facility.facility_name,
       _facility.facility_type,
       _report.reporting_period_duration,
       _naics.naics_classification,
       _naics.naics_code,
       _report.id as report_id,
       _organisation.id as organisation_id,
       _facility.id as facility_id,
       _report.swrs_report_id,
       _organisation.swrs_organisation_id,
       _facility.swrs_facility_id
from ggircs.report as _report
       left join ggircs.single_facility as _facility on _report.id = _facility.report_id
       left join ggircs.naics as _naics on _report.id = _naics.report_id
       left join ggircs.organisation as _organisation on _report.ghgr_import_id = _organisation.ghgr_import_id;

commit;
