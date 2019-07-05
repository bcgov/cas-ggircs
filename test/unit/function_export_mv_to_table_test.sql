set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- Run table export function
select ggircs_swrs.export_mv_to_table();

insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>EIO</FacilityType>
    <OrganisationId>00001</OrganisationId>
    <ReportingPeriodDuration>2025</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-27T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <OperationalWorkerReport/>
</ReportData>
$$);

-- Refresh function populates materialized views
select ggircs_swrs.refresh_materialized_views('with data');
select isnt_empty('select * from ggircs_swrs.report', 'refresh_materialized_views() has populated materialized views');

-- Function export_mv_to_table exists
select has_function( 'ggircs_swrs', 'export_mv_to_table', 'Schema ggircs_swrs has function export_mv_to_table()' );

-- refresh views with no data
select ggircs_swrs.refresh_materialized_views('with no data');

-- Refresh function has cleared materialized views
select is_empty('select * from ggircs_swrs.report where false', 'refresh_materialized_views() has cleared materialized views');

select * from finish();
rollback;
