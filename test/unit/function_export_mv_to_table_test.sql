set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- Run table export function
select swrs_transform.load();

insert into swrs_extract.ghgr_import (xml_file) values ($$
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
select swrs_transform.transform('with data');
select isnt_empty('select * from swrs_transform.report', 'transform() has populated materialized views');

-- Function load exists
select has_function( 'ggircs_swrs', 'load', 'Schema ggircs_swrs has function load()' );

-- refresh views with no data
select swrs_transform.transform('with no data');

-- Refresh function has cleared materialized views
select is_empty('select * from swrs_transform.report where false', 'transform() has cleared materialized views');

select * from finish();
rollback;
