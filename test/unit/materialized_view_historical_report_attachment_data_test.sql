set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- Test matview report exists in schema swrs_transform
select has_materialized_view('swrs_transform', 'historical_report_attachment_data', 'Materialized view historical_report_attachment_data exists');

-- Setup fixture
insert into swrs_extract.eccc_xml_file (imported_at, xml_file) VALUES ('2018-09-29T11:55:39.423', $$
  <Root>
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
    </Root>
$$);

-- Ensure fixture is processed correctly
refresh materialized view swrs_transform.historical_report_attachment_data with data;

-- select * from swrs_extract.eccc_xml_file;
select * from swrs_transform.historical_report_attachment_data;


select finish();
rollback;
