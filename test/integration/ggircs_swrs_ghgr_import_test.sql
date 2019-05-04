set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(8);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select distinct tag.name
    from x,
         xmltable('/*' passing xml_file columns name text path 'name(.)') as tag
    order by tag.name;
  $$,
  ARRAY['ReportData'::text],
  'The only allowable root tag is <ReportData>'
);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('/ReportData' passing xml_file columns xml_hunk text path '.') as tag;
  $$, $$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('//ReportData' passing xml_file columns xml_hunk text path '.') as tag;
  $$,
  'There are no <ReportData> tags anywhere except the top level'
);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select distinct tag.name
    from x,
         xmltable('/ReportData/*' passing xml_file columns name text path 'name(.)') as tag
    order by tag.name;
  $$,
  ARRAY[
    'ActivityData'::text,
    'LegalSubmissionData'::text,
    'OperationalWorkerReport'::text,
    'OperationalWorkerReports'::text,
    'RegistrationData'::text,
    'ReportDetails'::text,
    'SaleClosePurchase'::text,
    'VerifyTombstone'::text
    ],
  'The allowable <ReportData> child tags have not changed'
);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('/ReportData/ActivityData' passing xml_file columns xml_hunk text path '.') as tag;
  $$, $$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('//ActivityData' passing xml_file columns xml_hunk text path '.') as tag;
  $$,
  'The <ActivityData> tag is always a child of <ReportData>'
);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('/ReportData/LegalSubmissionData' passing xml_file columns xml_hunk text path '.') as tag;
  $$, $$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('//LegalSubmissionData' passing xml_file columns xml_hunk text path '.') as tag;
  $$,
  'The <LegalSubmissionData> tag is always a child of <ReportData>'
);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('/ReportData/OperationalWorkerReport|/ReportData/OperationalWorkerReports/OperationalWorkerReport' passing xml_file columns xml_hunk text path '.') as tag;
  $$, $$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('//OperationalWorkerReport' passing xml_file columns xml_hunk text path '.') as tag;
  $$,
  'The <OperationalWorkerReport> tag is always either a child of <ReportData> or <OperationalWorkerReports>'
);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('/ReportData/OperationalWorkerReports' passing xml_file columns xml_hunk text path '.') as tag;
  $$, $$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('//OperationalWorkerReports' passing xml_file columns xml_hunk text path '.') as tag;
  $$,
  'The <OperationalWorkerReports> tag is always a child of <ReportData>'
);

select results_eq($$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('/ReportData/RegistrationData' passing xml_file columns xml_hunk text path '.') as tag;
  $$, $$
    with x as (select id, xml_file from ggircs_swrs.ghgr_import)
    select count(tag)
    from x,
         xmltable('//RegistrationData' passing xml_file columns xml_hunk text path '.') as tag;
  $$,
  'The <RegistrationData> tag is always a child of <ReportData>'
);


select finish();
rollback;
