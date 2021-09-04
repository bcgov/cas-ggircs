set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(6);

-- Test matview report exists in schema swrs_transform
select has_materialized_view('swrs_transform', 'historical_report_attachment_data', 'Materialized view historical_report_attachment_data exists');

-- Setup fixture
insert into swrs_extract.eccc_zip_file (zip_file_name) values ('GHGBC_PROD_20180930.zip');

insert into swrs_extract.eccc_xml_file (imported_at, zip_file_id, xml_file) VALUES ('2018-09-29T11:55:39.423',
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
        <SubProcess SubprocessName="Comments Regarding GHG Reporting" InformationRequirement="Optional">
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
            <UploadedFileName>Plant PFD for Reports.pdf</UploadedFileName>
            <UploadedBy>Bob Lobblaw</UploadedBy>
            <UploadedDate>2021-04-28T18:25:45-07</UploadedDate>
          </FileDetails>
        </SubProcess>
      </Process>
    </ProcessFlowDiagram>
    <EmptyFile>
      <Process ProcessName="EmptyFile">
        <SubProcess SubprocessName="File Number is Empty">
          <FileDetails>
            <File></File>
            <UploadedFileName>emptyfilenumber.pdf</UploadedFileName>
            <UploadedBy>Nofile McEmpty</UploadedBy>
            <UploadedDate>2021-04-28T18:25:45-07</UploadedDate>
          </FileDetails>
        </SubProcess>
      </Process>
    </EmptyFile>
    <BadDate>
      <Process ProcessName="BadDate">
        <SubProcess SubprocessName="BadDate">
          <FileDetails>
            <File>100</File>
            <UploadedFileName>badDate.pdf</UploadedFileName>
            <UploadedBy>BadDate Dude</UploadedBy>
            <UploadedDate>24/04/2017 6:18:07 PM</UploadedDate>
          </FileDetails>
        </SubProcess>
      </Process>
    </BadDate>
    <FileNameSpace>
      <Process ProcessName="FileNameSpace">
        <SubProcess SubprocessName="FileNameSpace">
          <FileDetails>
            <File>666</File>
            <UploadedFileName>Space  Time.pdf</UploadedFileName>
            <UploadedBy>Bob Lobblaw</UploadedBy>
            <UploadedDate>2021-04-28T18:25:45-07</UploadedDate>
          </FileDetails>
        </SubProcess>
      </Process>
    </FileNameSpace>
    </ReportData>
$$);

-- Ensure fixture is processed correctly
refresh materialized view swrs_transform.historical_report_attachment_data with data;

select is_empty(
  $$
    select * from swrs_transform.historical_report_attachment_data where file_number in (38, 39)
  $$,
  'Does not parse data where the UploadedFileName tag does not exist or is empty'
);

select results_eq(
  $$
    select
      process_name,
      sub_process_name,
      uploaded_file_name,
      information_requirement,
      file_number,
      uploaded_by,
      uploaded_at
    from swrs_transform.historical_report_attachment_data limit 1
  $$,
  $$
    values (
      'ProcessFlowDiagram'::varchar,
      'A Process Flow Diagram is required for SFO and LFO (Parent) reports'::varchar,
      'Plant PFD for Reports.pdf'::varchar,
      'Required'::varchar,
      44::int,
      'Bob Lobblaw'::varchar,
      '2021-04-28 18:25:45-07'::timestamptz)
  $$,
  'Parses attachment data correctly where the UploadedFileName tag is not empty'
);

select results_eq(
  $$
    select
      process_name
    from swrs_transform.historical_report_attachment_data where file_number is null
  $$,
  $$
    values ('EmptyFile'::varchar)
  $$,
  'Parses empty fileNumber tags as null'
);

select results_eq(
  $$
    select
      uploaded_at
    from swrs_transform.historical_report_attachment_data where process_name = 'BadDate'
  $$,
  $$
    values (null::timestamptz)
  $$,
  'Parses malformed UploadedDate tags as null'
);

select results_eq(
  $$
    select
      uploaded_file_name
    from swrs_transform.historical_report_attachment_data where process_name = 'FileNameSpace'
  $$,
  $$
    values ('Space  Time.pdf'::varchar)
  $$,
  'Leaves spacing intact for filenames'
);

select finish();
rollback;
