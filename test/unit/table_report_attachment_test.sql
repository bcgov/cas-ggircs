set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(7);

-- Setup fixture
insert into swrs_extract.eccc_zip_file (zip_file_name) values ('GHGBC_PROD_20180930.zip');

insert into swrs_extract.eccc_attachment (
  imported_at, zip_file_id,
  attachment_uploaded_file_name,
  source_type_id,
  swrs_report_id,
  attachment_file_md5_hash,
  attachment_file_path
)
values (
  '2018-09-29T11:55:39.423',
  (select id from swrs_extract.eccc_zip_file limit 1),
  'Plant PFD for report_attachments.pdf',
  44,
  800855555,
  '01401078d49fca13af56f84ddff58f36', -- pragma: allowlist secret
  'Output_Prod/Report_800855555_2018_SourceTypeId_44_ProcessFlowDiagramPGI.pdf'
);

insert into swrs_extract.eccc_xml_file (imported_at, zip_file_id, xml_file) values ('2018-09-29T11:55:39.423',
  (select id from swrs_extract.eccc_zip_file limit 1), $$
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
    <ReportComments>
      <Process ProcessName="Comments and Supporting Information">
        <SubProcess SubprocessName="Comments Regarding GHG Reportting" InformationRequirement="Optional">
          <Comments>
            I am a comment
          </Comments>
          <FileDetails>
            <File>38</File>
          </FileDetails>
        </SubProcess>
      </Process>
    </ReportComments>
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
    select uploaded_file_name, md5_hash, file_path, zip_file_name  from swrs_history.report_attachment where process_name='ProcessFlowDiagram';
  $$,
  $$
    values(
      'Plant PFD for report_attachments.pdf'::varchar,
      '01401078d49fca13af56f84ddff58f36'::varchar, -- pragma: allowlist secret
      'Output_Prod/Report_800855555_2018_SourceTypeId_44_ProcessFlowDiagramPGI.pdf'::varchar,
      'GHGBC_PROD_20180930.zip'::varchar
    )
  $$,
  'The swrs_history.report_attachment received the correct attachment data'
);

-- report_attachment has the correct comment data
select results_eq(
  $$
    select comment  from swrs_history.report_attachment where process_name='Comments and Supporting Information';
  $$,
  $$
    values(
      'I am a comment'::varchar
    )
  $$,
  'The swrs_history.report_attachment received the correct comment data'
);

-- report_attachment does not have data where UploadedFileName does not exist and there are no comments
select is_empty(
  $$
    select * from swrs_history.report_attachment where process_name='ConfidentialityRequest';
  $$,
  'The swrs_history.report_attachment correctly ignored tags where UploadedFileName does not exist and there are no comments'
);

select * from finish();
rollback;
