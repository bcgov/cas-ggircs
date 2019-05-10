set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(30);

select has_materialized_view(
    'ggircs_swrs', 'parent_organisation',
    'ggircs_swrs.parent_organisation should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'parent_organisation', 'ggircs_parent_organisation_primary_key',
    'ggircs_swrs.parent_organisation should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'parent_organisation'::name, array[
    'ghgr_import_id'::name,
    'path_context'::name,
    'parent_organisation_idx'::name,
    'percentage_owned'::name,
    'french_trade_name'::name,
    'english_trade_name'::name,
    'duns'::name,
    'business_legal_name'::name,
    'website'::name
]);

select col_type_is(      'ggircs_swrs', 'parent_organisation', 'ghgr_import_id', 'integer', 'parent_organisation.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'ghgr_import_id', 'parent_organisation.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'path_context', 'parent_organisation.path_context column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'path_context', 'character varying(1000)', 'parent_organisation.path_context column should be type varchar');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'path_context', 'parent_organisation.path_context column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'path_context', 'parent_organisation.path_context column should not have a default');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'parent_organisation_idx', 'parent_organisation.parent_organisation_idx column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'parent_organisation_idx', 'integer', 'parent_organisation.parent_organisation_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'parent_organisation_idx', 'parent_organisation.parent_organisation_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'parent_organisation_idx', 'parent_organisation.parent_organisation_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'percentage_owned', 'parent_organisation.percentage_owned column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'percentage_owned', 'numeric(1000,2)', 'parent_organisation.percentage_owned column should be type numeric');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'percentage_owned', 'parent_organisation.percentage_owned column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'percentage_owned', 'parent_organisation.percentage_owned column should not have a default');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'french_trade_name', 'parent_organisation.french_trade_name column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'french_trade_name', 'character varying(1000)', 'parent_organisation.french_trade_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'french_trade_name', 'parent_organisation.french_trade_name column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'french_trade_name', 'parent_organisation.french_trade_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'english_trade_name', 'parent_organisation.english_trade_name column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'english_trade_name', 'character varying(1000)', 'parent_organisation.english_trade_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'english_trade_name', 'parent_organisation.english_trade_name column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'english_trade_name', 'parent_organisation.english_trade_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'duns', 'parent_organisation.duns column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'duns', 'character varying(1000)', 'parent_organisation.duns column should be type varchar');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'duns', 'parent_organisation.duns column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'duns', 'parent_organisation.duns column should not have a default');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'business_legal_name', 'parent_organisation.business_legal_name column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'business_legal_name', 'character varying(1000)', 'parent_organisation.business_legal_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'business_legal_name', 'parent_organisation.business_legal_name column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'business_legal_name', 'parent_organisation.business_legal_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'parent_organisation', 'website', 'parent_organisation.website column should exist');
select col_type_is(      'ggircs_swrs', 'parent_organisation', 'website', 'character varying(1000)', 'parent_organisation.website column should be type varchar');
select col_is_null(      'ggircs_swrs', 'parent_organisation', 'website', 'parent_organisation.website column should not allow null');
select col_hasnt_default('ggircs_swrs', 'parent_organisation', 'website', 'parent_organisation.website column should not have a default');


refresh materialized view ggircs_swrs.parent_organisation with data;
insert into ggircs_swrs.ghgr_import (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <ParentOrganisations>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>Spectra Energy Facilities Holdings Partnership</BusinessLegalName>
          <PercentageOwned>99.98</PercentageOwned>
        </Details>
        <Address>
          <MailingAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
    </ParentOrganisations>
  </RegistrationData>
  <ReportDetails>
    <OrganisationId>5485</OrganisationId>
  </ReportDetails>
</ReportData>
$$);

refresh materialized view ggircs_swrs.organisation with data;
refresh materialized view ggircs_swrs.parent_organisation with data;

select results_eq(
    'select organisation.ghgr_import_id from ggircs_swrs.parent_organisation ' ||
    'join ggircs_swrs.organisation ' ||
    'on ' ||
    'parent_organisation.ghgr_import_id = organisation.ghgr_import_id',

    'select ghgr_import_id from ggircs_swrs.organisation',

    'Foreign key ghgr_import_id in ggircs_swrs_parent_organisation references ggircs_swrs.organisation'
);

-- TODO: Add a fixture to test the veracity of what is being pulled in to this view from xml

select * from finish();
rollback;
