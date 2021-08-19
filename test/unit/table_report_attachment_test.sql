set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

-- Setup fixture
insert into swrs_extract.eccc_xml_file (imported_at, xml_file) VALUES ('2018-09-29T11:55:39.423', $$
  <ReportData>
    <ReportDetails>
      <ReportID>800855555</ReportID>
      <PrepopReportID></PrepopReportID>
      <ReportType>R7</ReportType>
      <FacilityId>666</FacilityId>
      <OrganisationId>1337</OrganisationId>
      <ReportingPeriodDuration>1999</ReportingPeriodDuration>
      <ReportStatus>
        <Status>In Progress</Status>
        <Version>3</Version>
        <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
        <LastModifiedDate>2018-09-28T11:55:39.423</LastModifiedDate>
      </ReportStatus>
    </ReportDetails>
    <report_attachmentComments>
      <Process ProcessName="Comments and Supporting Information">
        <SubProcess SubprocessName="Comments Regarding GHG report_attachmenting" InformationRequirement="Optional">
          <FileDetails>
            <File>38</File>
          </FileDetails>
        </SubProcess>
      </Process>
    </report_attachmentComments>
    <ConfidentialityRequest>
      <Process ProcessName="ConfidentialityRequest">
        <SubProcess SubprocessName="Confidentiality Request" InformationRequirement="Required">
          <IsRequestingConfidentiality>No</IsRequestingConfidentiality>
          <FileDetails>
            <File>39</File>
            <UploadedFileName/>
            <UploadedDate/>
          </FileDetails>
        </SubProcess>
      </Process>
    </ConfidentialityRequest>
    <ProcessFlowDiagram>
      <Process ProcessName="ProcessFlowDiagram">
        <SubProcess SubprocessName="A Process Flow Diagram is required for SFO and LFO (Parent) reports" InformationRequirement="Required">
          <FileDetails>
            <File>44</File>
            <UploadedFileName>Plant PFD for report_attachments.pdf</UploadedFileName>
            <UploadedBy>Bob Lobblaw</UploadedBy>
            <UploadedDate>2021-04-28T18:25:45-07</UploadedDate>
          </FileDetails>
        </SubProcess>
      </Process>
    </ProcessFlowDiagram>
  </ReportData>
$$);

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose

select swrs_transform.load(true, false);

-- Table swrs.report exists
select has_table('swrs_history'::name, 'report_attachment'::name);

-- report_attachment has pk
select has_pk('swrs_history', 'report_attachment', 'ggircs_report has primary key');

-- report_attachment has index
select has_index(
  'swrs_history',
  'report_attachment',
  'report_attachment_report_id_idx',
  'report_attachment has index: attachment_report_fkey');

-- report_attachment has data
select isnt_empty('select * from swrs_history.report_attachment', 'there is data in swrs_history.report_attachment');

-- report_attachment has the correct emission-total data
select results_eq(
  $$
    select uploaded_file_name from swrs_history.report_attachment;
  $$,
  $$
    values('Plant PFD for report_attachments.pdf'::varchar)
  $$,
  'The swrs_history.report_attachment received the correct data'
);

select * from finish();
rollback;
