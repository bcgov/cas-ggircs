set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(134);

select has_materialized_view(
    'ggircs_swrs', 'address',
    'ggircs_swrs.address should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'address', 'ggircs_address_primary_key',
    'ggircs_swrs.address should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'address'::name, array[
    'ghgr_import_id'::name,
    'swrs_facility_id'::name,
    'swrs_organisation_id'::name,
    'path_context'::name,
    'type'::name,
    'contact_idx'::name,
    'parent_organisation_idx'::name,
    'physical_address_municipality'::name,
    'physical_address_unit_number'::name,
    'physical_address_street_number'::name,
    'physical_address_street_number_suffix'::name,
    'physical_address_street_name'::name,
    'physical_address_street_type'::name,
    'physical_address_street_direction'::name,
    'physical_address_prov_terr_state'::name,
    'physical_address_postal_code_zip_code'::name,
    'physical_address_country'::name,
    'physical_address_national_topographical_description'::name,
    'physical_address_additional_information'::name,
    'physical_address_land_survey_description'::name,

    'mailing_address_delivery_mode'::name,
    'mailing_address_po_box_number'::name,
    'mailing_address_unit_number'::name,
    'mailing_address_rural_route_number'::name,
    'mailing_address_street_number'::name,
    'mailing_address_street_number_suffix'::name,
    'mailing_address_street_name'::name,
    'mailing_address_street_type'::name,
    'mailing_address_street_direction'::name,
    'mailing_address_municipality'::name,
    'mailing_address_prov_terr_state'::name,
    'mailing_address_postal_code_zip_code'::name,
    'mailing_address_country'::name,
    'mailing_address_additional_information'::name,

    'geographic_address_latitude'::name,
    'geographic_address_longitude'::name
]);

select col_type_is(      'ggircs_swrs', 'address', 'ghgr_import_id', 'integer', 'address.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'address', 'ghgr_import_id', 'address.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'address', 'swrs_facility_id', 'address.swrs_facility_id column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'swrs_facility_id', 'numeric(1000,0)', 'address.swrs_facility_id column should be type numeric');
select col_is_null(      'ggircs_swrs', 'address', 'swrs_facility_id', 'address.swrs_facility_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'swrs_facility_id', 'address.swrs_facility_id column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'swrs_organisation_id', 'address.swrs_organisation_id column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'swrs_organisation_id', 'numeric(1000,0)', 'address.swrs_organisation_id column should be type numeric');
select col_is_null(      'ggircs_swrs', 'address', 'swrs_organisation_id', 'address.swrs_organisation_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'swrs_organisation_id', 'address.swrs_organisation_id column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'path_context', 'address.path_context column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'path_context', 'character varying(1000)', 'address.path_context column should be type varchar');
select col_hasnt_default('ggircs_swrs', 'address', 'path_context', 'address.context column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'type', 'address.type column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'type', 'character varying(1000)', 'address.type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'type', 'address.type column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'type', 'address.type column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'contact_idx', 'address.contact_idx column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'contact_idx', 'integer', 'address.contact_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'address', 'contact_idx', 'address.contact_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'contact_idx', 'address.contact_idx column should not have a default');

--  Physical Address Columns
--  select has_column(       'ggircs_swrs', 'address', 'parent_organisation_idx', 'address.parent_organisation_idx column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'parent_organisation_idx', 'integer', 'address.parent_organisation_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'address', 'parent_organisation_idx', 'address.parent_organisation_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'parent_organisation_idx', 'address.parent_organisation_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_municipality', 'address.physical_address_municipality column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_municipality', 'character varying(1000)', 'address.physical_address_municipality column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_municipality', 'address.physical_address_municipality column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_municipality', 'address.physical_address_municipality column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_unit_number', 'address.physical_address_unit_number column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_unit_number', 'character varying(1000)', 'address.physical_address_unit_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_unit_number', 'address.physical_address_unit_number column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_unit_number', 'address.physical_address_unit_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_street_number', 'address.physical_address_street_number column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_street_number', 'character varying(1000)', 'address.physical_address_street_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_street_number', 'address.physical_address_street_number column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_street_number', 'address.physical_address_street_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_street_number_suffix', 'address.physical_address_street_number_suffix column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_street_number_suffix', 'character varying(1000)', 'address.physical_address_street_number_suffix column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_street_number_suffix', 'address.physical_address_street_number_suffix column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_street_number_suffix', 'address.physical_address_street_number_suffix column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_street_name', 'address.physical_address_street_name column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_street_name', 'character varying(1000)', 'address.physical_address_street_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_street_name', 'address.physical_address_street_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_street_name', 'address.physical_address_street_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_street_type', 'address.physical_address_street_type column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_street_type', 'character varying(1000)', 'address.physical_address_street_type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_street_type', 'address.physical_address_street_type column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_street_type', 'address.physical_address_street_type column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_street_direction', 'address.physical_address_street_direction column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_street_direction', 'character varying(1000)', 'address.physical_address_street_direction column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_street_direction', 'address.physical_address_street_direction column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_street_direction', 'address.physical_address_street_direction column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_prov_terr_state', 'address.physical_address_prov_terr_state column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_prov_terr_state', 'character varying(1000)', 'address.physical_address_prov_terr_state column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_prov_terr_state', 'address.physical_address_prov_terr_state column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_prov_terr_state', 'address.physical_address_prov_terr_state column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_postal_code_zip_code', 'address.physical_address_postal_code_zip_code column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_postal_code_zip_code', 'character varying(1000)', 'address.physical_address_postal_code_zip_code column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_postal_code_zip_code', 'address.physical_address_postal_code_zip_code column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_postal_code_zip_code', 'address.physical_address_postal_code_zip_code column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_country', 'address.physical_address_country column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_country', 'character varying(1000)', 'address.physical_address_country column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_country', 'address.physical_address_country column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_country', 'address.physical_address_country column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'physical_address_additional_information', 'address.physical_address_additional_information column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'physical_address_additional_information', 'character varying(10000)', 'address.physical_address_additional_information column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'physical_address_additional_information', 'address.physical_address_additional_information column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'physical_address_additional_information', 'address.physical_address_additional_information column should not have a default');

--  Mailing Address Columns
--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_delivery_mode', 'address.mailing_address_delivery_mode column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_delivery_mode', 'character varying(1000)', 'address.mailing_address_delivery_mode column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_delivery_mode', 'address.mailing_address_delivery_mode column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_delivery_mode', 'address.mailing_address_delivery_mode column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_po_box_number', 'address.mailing_address_po_box_number column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_po_box_number', 'character varying(1000)', 'address.mailing_address_po_box_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_po_box_number', 'address.mailing_address_po_box_number column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_po_box_number', 'address.mailing_address_po_box_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_unit_number', 'address.mailing_address_unit_number column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_unit_number', 'character varying(1000)', 'address.mailing_address_unit_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_unit_number', 'address.mailing_address_unit_number column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_unit_number', 'address.mailing_address_unit_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_rural_route_number', 'address.mailing_address_rural_route_number column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_rural_route_number', 'character varying(1000)', 'address.mailing_address_rural_route_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_rural_route_number', 'address.mailing_address_rural_route_number column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_rural_route_number', 'address.mailing_address_rural_route_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_street_number', 'address.mailing_address_street_number column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_street_number', 'character varying(1000)', 'address.mailing_address_street_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_street_number', 'address.mailing_address_street_number column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_street_number', 'address.mailing_address_street_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_street_number_suffix', 'address.mailing_address_street_number_suffix column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_street_number_suffix', 'character varying(1000)', 'address.mailing_address_street_number_suffix column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_street_number_suffix', 'address.mailing_address_street_number_suffix column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_street_number_suffix', 'address.mailing_address_street_number_suffix column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_street_name', 'address.mailing_address_street_name column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_street_name', 'character varying(1000)', 'address.mailing_address_street_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_street_name', 'address.mailing_address_street_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_street_name', 'address.mailing_address_street_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_street_type', 'address.mailing_address_street_type column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_street_type', 'character varying(1000)', 'address.mailing_address_street_type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_street_type', 'address.mailing_address_street_type column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_street_type', 'address.mailing_address_street_type column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_street_direction', 'address.mailing_address_street_direction column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_street_direction', 'character varying(1000)', 'address.mailing_address_street_direction column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_street_direction', 'address.mailing_address_street_direction column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_street_direction', 'address.mailing_address_street_direction column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_prov_terr_state', 'address.mailing_address_prov_terr_state column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_prov_terr_state', 'character varying(1000)', 'address.mailing_address_prov_terr_state column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_prov_terr_state', 'address.mailing_address_prov_terr_state column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_prov_terr_state', 'address.mailing_address_prov_terr_state column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_postal_code_zip_code', 'address.mailing_address_postal_code_zip_code column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_postal_code_zip_code', 'character varying(1000)', 'address.mailing_address_postal_code_zip_code column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_postal_code_zip_code', 'address.mailing_address_postal_code_zip_code column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_postal_code_zip_code', 'address.mailing_address_postal_code_zip_code column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_country', 'address.mailing_address_country column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_country', 'character varying(1000)', 'address.mailing_address_country column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_country', 'address.mailing_address_country column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_country', 'address.mailing_address_country column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'mailing_address_additional_information', 'address.mailing_address_additional_information column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'mailing_address_additional_information', 'character varying(10000)', 'address.mailing_address_additional_information column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'mailing_address_additional_information', 'address.mailing_address_additional_information column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'mailing_address_additional_information', 'address.mailing_address_additional_information column should not have a default');

--  Geographic Address Columns
--  select has_column(       'ggircs_swrs', 'address', 'geographic_address_latitude', 'address.geographic_address_latitude column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'geographic_address_latitude', 'character varying(1000)', 'address.geographic_address_latitude column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'geographic_address_latitude', 'address.geographic_address_latitude column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'geographic_address_latitude', 'address.geographic_address_latitude column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'geographic_address_longitude', 'address.geographic_address_longitude column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'geographic_address_longitude', 'character varying(1000)', 'address.geographic_address_longitude column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'geographic_address_longitude', 'address.geographic_address_longitude column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'geographic_address_longitude', 'address.geographic_address_longitude column should not have a default');

-- insert necessary data into table ghgr_import
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Address>
        <PhysicalAddress>
          <UnitNumber>1</UnitNumber>
          <StreetNumber>1234</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>00th</StreetName>
          <StreetType>Avenue</StreetType>
          <StreetDirection>NW</StreetDirection>
          <Municipality>Fort Nelson</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H 0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <NationalTopographicalDescription>A-123-B/456-C-00</NationalTopographicalDescription>
          <AdditionalInformation>INFO</AdditionalInformation>
          <LandSurveyDescription>OOH shiny!</LandSurveyDescription>
        </PhysicalAddress>
        <MailingAddress>
          <DeliveryMode>Post Office Box</DeliveryMode>
          <POBoxNumber>0000</POBoxNumber>
          <StreetNumber>1234</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>00th</StreetName>
          <StreetType>Avenue</StreetType>
          <Municipality>Fort Nelson</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H 0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <AdditionalInformation>The site is located at A-123-B-456-C-789</AdditionalInformation>
        </MailingAddress>
        <GeographicAddress>
          <Latitude>23.45125</Latitude>
          <Longitude>-90.59062</Longitude>
        </GeographicAddress>
      </Address>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
    <OrganisationId>50804</OrganisationId>
  </ReportDetails>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.organisation with data;
refresh materialized view ggircs_swrs.contact with data;
refresh materialized view ggircs_swrs.parent_organisation with data;
refresh materialized view ggircs_swrs.address with data;

-- Test the fk relations from address to: facility, organisation, contact, parent_organisation
select results_eq(
    'select facility.ghgr_import_id from ggircs_swrs.address ' ||
    'join ggircs_swrs.facility ' ||
    'on ' ||
    'address.ghgr_import_id =  facility.ghgr_import_id',

    'select ghgr_import_id from ggircs_swrs.facility',

    'Foreign key ghgr_import_id in ggircs_swrs_address references ggircs_swrs.facility'
);

select results_eq(
    'select organisation.ghgr_import_id from ggircs_swrs.address ' ||
    'join ggircs_swrs.organisation ' ||
    'on ' ||
    'address.ghgr_import_id =  organisation.ghgr_import_id',

    'select ghgr_import_id from ggircs_swrs.organisation',

    'Foreign key ghgr_import_id in ggircs_swrs_address references ggircs_swrs.organisation'
);

-- test the columnns for ggircs_swrs.address have been properly parsed from xml
select results_eq(
  'select ghgr_import_id from ggircs_swrs.address',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.address parsed column ghgr_import_id'
);
select results_eq(
  'select path_context from ggircs_swrs.address',
  ARRAY['RegistrationData'::varchar],
  'ggircs_swrs.address parsed column path_context'
);

select results_eq(
  'select type from ggircs_swrs.address',
  ARRAY['Facility'::varchar],
  'ggircs_swrs.address parsed column type'
);
select results_eq(
  'select swrs_facility_id from ggircs_swrs.address',
  ARRAY[666::numeric],
  'ggircs_swrs.address parsed column swrs_facility_id'
);
-- test that the swrs_organisation_id is null when getting address from the context of facility
select results_eq(
  'select swrs_organisation_id from ggircs_swrs.address',
  ARRAY[null::numeric],
  'ggircs_swrs.address parsed column swrs_organisation_id'
);

-- Physical Address columns
select results_eq(
  'select physical_address_unit_number from ggircs_swrs.address',
  ARRAY[1::varchar],
  'ggircs_swrs.address parsed column physical_address_unit_number'
);
select results_eq(
  'select physical_address_street_number from ggircs_swrs.address',
  ARRAY[1234::varchar],
  'ggircs_swrs.address parsed column physical_address_street_number'
);
select results_eq(
  'select physical_address_street_number_suffix from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column physical_address_street_number_suffix'
);
select results_eq(
  'select physical_address_street_name from ggircs_swrs.address',
  ARRAY['00th'::varchar],
  'ggircs_swrs.address parsed column physical_address_municipality'
);
select results_eq(
  'select physical_address_street_type from ggircs_swrs.address',
  ARRAY['Avenue'::varchar],
  'ggircs_swrs.address parsed column physical_address_street_type'
);
select results_eq(
  'select physical_address_street_direction from ggircs_swrs.address',
  ARRAY['NW'::varchar],
  'ggircs_swrs.address parsed column physical_address_street_direction'
);
select results_eq(
  'select physical_address_municipality from ggircs_swrs.address',
  ARRAY['Fort Nelson'::varchar],
  'ggircs_swrs.address parsed column physical_address_municipality'
);
select results_eq(
  'select physical_address_prov_terr_state from ggircs_swrs.address',
  ARRAY['British Columbia'::varchar],
  'ggircs_swrs.address parsed column physical_address_prov_terr_state'
);
select results_eq(
  'select physical_address_postal_code_zip_code from ggircs_swrs.address',
  ARRAY['H0H 0H0'::varchar],
  'ggircs_swrs.address parsed column physical_address_postal_code_zip_code'
);
select results_eq(
  'select physical_address_country from ggircs_swrs.address',
  ARRAY['Canada'::varchar],
  'ggircs_swrs.address parsed column physical_address_country'
);
select results_eq(
  'select physical_address_national_topographical_description from ggircs_swrs.address',
  ARRAY['A-123-B/456-C-00'::varchar],
  'ggircs_swrs.address parsed column physical_address_national_topographical_description'
);
select results_eq(
  'select physical_address_additional_information from ggircs_swrs.address',
  ARRAY['INFO'::varchar],
  'ggircs_swrs.address parsed column physical_address_additional_information'
);
select results_eq(
  'select physical_address_land_survey_description from ggircs_swrs.address',
  ARRAY['OOH shiny!'::varchar],
  'ggircs_swrs.address parsed column physical_address_land_survey_description'
);

-- Mailing Address Columns
select results_eq(
  'select mailing_address_delivery_mode from ggircs_swrs.address',
  ARRAY['Post Office Box'::varchar],
  'ggircs_swrs.address parsed column mailing_address_delivery_mode'
);
select results_eq(
  'select mailing_address_po_box_number from ggircs_swrs.address',
  ARRAY['0000'::varchar],
  'ggircs_swrs.address parsed column mailing_address_po_box_number'
);
select results_eq(
  'select mailing_address_unit_number from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column mailing_address_unit_number'
);
select results_eq(
  'select mailing_address_rural_route_number from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column mailing_address_rural_route_number'
);
select results_eq(
  'select mailing_address_street_number from ggircs_swrs.address',
  ARRAY[1234::varchar],
  'ggircs_swrs.address parsed column mailing_address_street_number'
);
select results_eq(
  'select mailing_address_street_number_suffix from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column mailing_address_street_number_suffix'
);
select results_eq(
  'select mailing_address_street_name from ggircs_swrs.address',
  ARRAY['00th'::varchar],
  'ggircs_swrs.address parsed column mailing_address_street_name'
);
select results_eq(
  'select mailing_address_street_type from ggircs_swrs.address',
  ARRAY['Avenue'::varchar],
  'ggircs_swrs.address parsed column mailing_address_street_type'
);
select results_eq(
  'select mailing_address_street_direction from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column mailing_address_street_direction'
);
select results_eq(
  'select mailing_address_municipality from ggircs_swrs.address',
  ARRAY['Fort Nelson'::varchar],
  'ggircs_swrs.address parsed column mailing_address_municipality'
);
select results_eq(
  'select mailing_address_prov_terr_state from ggircs_swrs.address',
  ARRAY['British Columbia'::varchar],
  'ggircs_swrs.address parsed column mailing_address_prov_terr_state'
);
select results_eq(
  'select mailing_address_postal_code_zip_code from ggircs_swrs.address',
  ARRAY['H0H 0H0'::varchar],
  'ggircs_swrs.address parsed column mailing_address_postal_code_zip_code'
);
select results_eq(
  'select mailing_address_country from ggircs_swrs.address',
  ARRAY['Canada'::varchar],
  'ggircs_swrs.address parsed column mailing_address_country'
);
select results_eq(
  'select mailing_address_additional_information from ggircs_swrs.address',
  ARRAY['The site is located at A-123-B-456-C-789'::varchar],
  'ggircs_swrs.address parsed column mailing_address_additional_information'
);

-- Geographic Address columns
select results_eq(
  'select geographic_address_latitude from ggircs_swrs.address',
  ARRAY['23.45125'::varchar],
  'ggircs_swrs.address parsed column geographic_address_latitude'
);
select results_eq(
  'select geographic_address_longitude from ggircs_swrs.address',
  ARRAY['-90.59062'::varchar],
  'ggircs_swrs.address parsed column geographic_address_longitude'
);

select finish();
rollback;

-- TODO: Create separate tests for organisation data?

-- organisation fixture data

-- <Organisation>
--       <Address>
--         <PhysicalAddress>
--           <UnitNumber>1</UnitNumber>
--           <StreetNumber>123</StreetNumber>
--           <StreetNumberSuffix/>
--           <StreetName>1st</StreetName>
--           <StreetType>Street</StreetType>
--           <StreetDirection>Southwest</StreetDirection>
--           <Municipality>Utopia</Municipality>
--           <ProvTerrState>British Columbia</ProvTerrState>
--           <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
--           <Country>Canada</Country>
--         </PhysicalAddress>
--         <MailingAddress>
--           <UnitNumber>1</UnitNumber>
--           <StreetNumber>123</StreetNumber>
--           <StreetNumberSuffix/>
--           <StreetName>1st </StreetName>
--           <StreetType>Street</StreetType>
--           <StreetDirection>Southwest</StreetDirection>
--           <Municipality>Utopia</Municipality>
--           <ProvTerrState>Alberta</ProvTerrState>
--           <PostalCodeZipCode>H0H 0H0</PostalCodeZipCode>
--           <Country>Canada</Country>
--           <AdditionalInformation/>
--         </MailingAddress>
--       </Address>
--     </Organisation>
