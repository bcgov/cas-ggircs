set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(38);

select has_materialized_view(
    'swrs_transform', 'parent_organisation',
    'swrs_transform.parent_organisation should be a materialized view'
);

select has_index(
    'swrs_transform', 'parent_organisation', 'ggircs_parent_organisation_primary_key',
    'swrs_transform.parent_organisation should have a primary key'
);

select columns_are('swrs_transform'::name, 'parent_organisation'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'path_context'::name,
    'parent_organisation_idx'::name,
    'percentage_owned'::name,
    'french_trade_name'::name,
    'english_trade_name'::name,
    'duns'::name,
    'business_legal_name'::name,
    'website'::name
]);

select col_type_is(      'swrs_transform', 'parent_organisation', 'eccc_xml_file_id', 'integer', 'parent_organisation.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'eccc_xml_file_id', 'parent_organisation.eccc_xml_file_id column should not have a default value');

--  select has_column(       'swrs_transform', 'parent_organisation', 'path_context', 'parent_organisation.path_context column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'path_context', 'character varying(1000)', 'parent_organisation.path_context column should be type varchar');
select col_is_null(      'swrs_transform', 'parent_organisation', 'path_context', 'parent_organisation.path_context column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'path_context', 'parent_organisation.path_context column should not have a default');

--  select has_column(       'swrs_transform', 'parent_organisation', 'parent_organisation_idx', 'parent_organisation.parent_organisation_idx column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'parent_organisation_idx', 'integer', 'parent_organisation.parent_organisation_idx column should be type integer');
select col_is_null(      'swrs_transform', 'parent_organisation', 'parent_organisation_idx', 'parent_organisation.parent_organisation_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'parent_organisation_idx', 'parent_organisation.parent_organisation_idx column should not have a default');

--  select has_column(       'swrs_transform', 'parent_organisation', 'percentage_owned', 'parent_organisation.percentage_owned column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'percentage_owned', 'numeric', 'parent_organisation.percentage_owned column should be type numeric');
select col_is_null(      'swrs_transform', 'parent_organisation', 'percentage_owned', 'parent_organisation.percentage_owned column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'percentage_owned', 'parent_organisation.percentage_owned column should not have a default');

--  select has_column(       'swrs_transform', 'parent_organisation', 'french_trade_name', 'parent_organisation.french_trade_name column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'french_trade_name', 'character varying(1000)', 'parent_organisation.french_trade_name column should be type varchar');
select col_is_null(      'swrs_transform', 'parent_organisation', 'french_trade_name', 'parent_organisation.french_trade_name column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'french_trade_name', 'parent_organisation.french_trade_name column should not have a default');

--  select has_column(       'swrs_transform', 'parent_organisation', 'english_trade_name', 'parent_organisation.english_trade_name column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'english_trade_name', 'character varying(1000)', 'parent_organisation.english_trade_name column should be type varchar');
select col_is_null(      'swrs_transform', 'parent_organisation', 'english_trade_name', 'parent_organisation.english_trade_name column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'english_trade_name', 'parent_organisation.english_trade_name column should not have a default');

--  select has_column(       'swrs_transform', 'parent_organisation', 'duns', 'parent_organisation.duns column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'duns', 'character varying(1000)', 'parent_organisation.duns column should be type varchar');
select col_is_null(      'swrs_transform', 'parent_organisation', 'duns', 'parent_organisation.duns column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'duns', 'parent_organisation.duns column should not have a default');

--  select has_column(       'swrs_transform', 'parent_organisation', 'business_legal_name', 'parent_organisation.business_legal_name column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'business_legal_name', 'character varying(1000)', 'parent_organisation.business_legal_name column should be type varchar');
select col_is_null(      'swrs_transform', 'parent_organisation', 'business_legal_name', 'parent_organisation.business_legal_name column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'business_legal_name', 'parent_organisation.business_legal_name column should not have a default');

--  select has_column(       'swrs_transform', 'parent_organisation', 'website', 'parent_organisation.website column should exist');
select col_type_is(      'swrs_transform', 'parent_organisation', 'website', 'character varying(1000)', 'parent_organisation.website column should be type varchar');
select col_is_null(      'swrs_transform', 'parent_organisation', 'website', 'parent_organisation.website column should not allow null');
select col_hasnt_default('swrs_transform', 'parent_organisation', 'website', 'parent_organisation.website column should not have a default');


refresh materialized view swrs_transform.parent_organisation with data;
insert into swrs_extract.eccc_xml_file (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <ParentOrganisations>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>abc</BusinessLegalName>
          <PercentageOwned>99.98</PercentageOwned>
          <FrenchTradeName>abc</FrenchTradeName>
          <EnglishTradeName>abc</EnglishTradeName>
          <DUNSNumber>1</DUNSNumber>
          <WebSite>www.hockeyisgood.com</WebSite>
        </Details>
      </ParentOrganisation>
    </ParentOrganisations>
  </RegistrationData>
  <ReportDetails>
    <OrganisationId>1234</OrganisationId>
  </ReportDetails>
</ReportData>
$$);

refresh materialized view swrs_transform.organisation with data;
refresh materialized view swrs_transform.parent_organisation with data;

select results_eq(
     $$
     select organisation.eccc_xml_file_id from swrs_transform.parent_organisation
     join swrs_transform.organisation
     on
     parent_organisation.eccc_xml_file_id = organisation.eccc_xml_file_id
     $$,

    'select eccc_xml_file_id from swrs_transform.organisation',

    'Foreign key eccc_xml_file_id in ggircs_swrs_parent_organisation references swrs_transform.organisation'
);

-- XML import tests
select results_eq(
    'select eccc_xml_file_id from swrs_transform.parent_organisation',
    'select id from swrs_extract.eccc_xml_file',
    'column eccc_xml_file_id in parent_organisation correctly parsed xml'
);

select results_eq(
    'select path_context from swrs_transform.parent_organisation',
    ARRAY['RegistrationData'::varchar],
    'column path_context in parent_organisation correctly parsed xml'
);

select results_eq(
    'select parent_organisation_idx from swrs_transform.parent_organisation',
    ARRAY[0::integer],
    'column parent_organisation_idx in parent_organisation correctly parsed xml'
);

select results_eq(
    'select percentage_owned from swrs_transform.parent_organisation',
    ARRAY[99.98::numeric],
    'column percentage_owned in parent_organisation correctly parsed xml'
);

select results_eq(
    'select french_trade_name from swrs_transform.parent_organisation',
    ARRAY['abc'::varchar],
    'column french_trade_name in parent_organisation correctly parsed xml'
);

select results_eq(
    'select english_trade_name from swrs_transform.parent_organisation',
    ARRAY['abc'::varchar],
    'column french_trade_name in parent_organisation correctly parsed xml'
);

select results_eq(
    'select duns from swrs_transform.parent_organisation',
    ARRAY[1::varchar],
    'column duns in parent_organisation correctly parsed xml'
);

select results_eq(
    'select website from swrs_transform.parent_organisation',
    ARRAY['www.hockeyisgood.com'::varchar],
    'column website in parent_organisation correctly parsed xml'
);

select * from finish();
rollback;
