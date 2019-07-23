set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(232);

select has_materialized_view(
    'ggircs_swrs', 'address',
    'swrs_transform.address should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'address', 'ggircs_address_primary_key',
    'swrs_transform.address should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'address'::name, array[
    'id'::name,
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
select col_type_is(      'ggircs_swrs', 'address', 'swrs_facility_id', 'integer', 'address.swrs_facility_id column should be type numeric');
select col_is_null(      'ggircs_swrs', 'address', 'swrs_facility_id', 'address.swrs_facility_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'swrs_facility_id', 'address.swrs_facility_id column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'swrs_organisation_id', 'address.swrs_organisation_id column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'swrs_organisation_id', 'integer', 'address.swrs_organisation_id column should be type numeric');
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
select col_type_is(      'ggircs_swrs', 'address', 'geographic_address_latitude', 'numeric', 'address.geographic_address_latitude column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'geographic_address_latitude', 'address.geographic_address_latitude column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'geographic_address_latitude', 'address.geographic_address_latitude column should not have a default');

--  select has_column(       'ggircs_swrs', 'address', 'geographic_address_longitude', 'address.geographic_address_longitude column should exist');
select col_type_is(      'ggircs_swrs', 'address', 'geographic_address_longitude', 'numeric', 'address.geographic_address_longitude column should be type varchar');
select col_is_null(      'ggircs_swrs', 'address', 'geographic_address_longitude', 'address.geographic_address_longitude column should allow null');
select col_hasnt_default('ggircs_swrs', 'address', 'geographic_address_longitude', 'address.geographic_address_longitude column should not have a default');

-- insert necessary data into table ghgr_import
insert into swrs_extract.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Organisation>
      <Address>
        <PhysicalAddress>
          <UnitNumber>4321</UnitNumber>
          <StreetNumber>100</StreetNumber>
          <StreetName>111th Street West</StreetName>
          <StreetType>Street</StreetType>
          <StreetDirection>West</StreetDirection>
          <Municipality>Funkytown</Municipality>
          <ProvTerrState>Funky</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <NationalTopographicalDescription>A-123-B/456-C-00</NationalTopographicalDescription>
          <AdditionalInformation>INFO</AdditionalInformation>
          <LandSurveyDescription>OOH shiny!</LandSurveyDescription>
        </PhysicalAddress>
        <MailingAddress>
          <DeliveryMode>General Delivery</DeliveryMode>
          <POBoxNumber>0000</POBoxNumber>
          <UnitNumber>00</UnitNumber>
          <RuralRouteNumber>321</RuralRouteNumber>
          <StreetNumber>100</StreetNumber>
          <StreetNumberSuffix>B</StreetNumberSuffix>
          <StreetName>111th Street West</StreetName>
          <StreetType>Street</StreetType>
          <StreetDirection>West</StreetDirection>
          <Municipality>Funkytown</Municipality>
          <ProvTerrState>Funky</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <AdditionalInformation/>
        </MailingAddress>
        <GeographicAddress>
          <Latitude>23.45125</Latitude>
          <Longitude>-90.59062</Longitude>
        </GeographicAddress>
      </Address>
    </Organisation>
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
          <UnitNumber>1</UnitNumber>
          <RuralRouteNumber>321</RuralRouteNumber>
          <StreetNumber>1234</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>00th</StreetName>
          <StreetType>Avenue</StreetType>
          <StreetDirection>West</StreetDirection>
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
    <Contacts>
      <Contact>
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
              <UnitNumber>1</UnitNumber>
              <RuralRouteNumber>321</RuralRouteNumber>
              <StreetNumber>1234</StreetNumber>
              <StreetNumberSuffix/>
              <StreetName>00th</StreetName>
              <StreetType>Avenue</StreetType>
              <StreetDirection>West</StreetDirection>
              <Municipality>Fort Nelson</Municipality>
              <ProvTerrState>British Columbia</ProvTerrState>
              <PostalCodeZipCode>H0H 0H0</PostalCodeZipCode>
              <Country>Canada</Country>
              <AdditionalInformation>The site is located at A-123-B-456-C-789</AdditionalInformation>
          </MailingAddress>
        </Address>
      </Contact>
      <Contact>
        <Address>
          <PhysicalAddress>
            <StreetNumber>2</StreetNumber>
          </PhysicalAddress>
          <MailingAddress>
            <StreetNumber>2</StreetNumber>
          </MailingAddress>
        </Address>
      </Contact>
    </Contacts>
    <ParentOrganisations>
      <ParentOrganisation>
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
              <UnitNumber>1</UnitNumber>
              <RuralRouteNumber>321</RuralRouteNumber>
              <StreetNumber>1234</StreetNumber>
              <StreetNumberSuffix/>
              <StreetName>00th</StreetName>
              <StreetType>Avenue</StreetType>
              <StreetDirection>West</StreetDirection>
              <Municipality>Fort Nelson</Municipality>
              <ProvTerrState>British Columbia</ProvTerrState>
              <PostalCodeZipCode>H0H 0H0</PostalCodeZipCode>
              <Country>Canada</Country>
              <AdditionalInformation>The site is located at A-123-B-456-C-789</AdditionalInformation>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
      <ParentOrganisation>
        <Address>
          <PhysicalAddress>
            <UnitNumber>2</UnitNumber>
          </PhysicalAddress>
          <MailingAddress>
            <UnitNumber>2</UnitNumber>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
    </ParentOrganisations>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
    <OrganisationId>123</OrganisationId>
  </ReportDetails>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view swrs_transform.facility with data;
refresh materialized view swrs_transform.organisation with data;
refresh materialized view swrs_transform.contact with data;
refresh materialized view swrs_transform.parent_organisation with data;
refresh materialized view swrs_transform.address with data;

-- Test the fk relation from address to: facility
select results_eq(
    $$
    select facility.ghgr_import_id from swrs_transform.address
    join swrs_transform.facility
    on
    address.ghgr_import_id =  facility.ghgr_import_id and address.type ='Facility'
    $$,

    'select ghgr_import_id from swrs_transform.facility',

    'Foreign key ghgr_import_id in ggircs_swrs_address references swrs_transform.facility'
);

-- Test the fk relation from address to organisation
select results_eq(
    $$
    select organisation.ghgr_import_id from swrs_transform.address
    join swrs_transform.organisation
    on
    address.ghgr_import_id =  organisation.ghgr_import_id and address.type='Organisation'
    $$,

    'select ghgr_import_id from swrs_transform.organisation',

    'Foreign key ghgr_import_id in ggircs_swrs_address references swrs_transform.organisation'
);

-- Test the fk relation from address to contact
select results_eq(
    $$
    select contact.ghgr_import_id from swrs_transform.address
    join swrs_transform.contact
    on (
    address.ghgr_import_id = contact.ghgr_import_id
    and address.contact_idx = contact.contact_idx)
    and address.type='Contact'
    and address.contact_idx = 0
    $$,

    'select ghgr_import_id from swrs_transform.contact where contact.contact_idx= 0',

    'Foreign keys ghgr_import_id, contact_idx, in ggircs_swrs_address reference swrs_transform.contact'
);

-- Test the fk relation from address to parent_organisation
select results_eq(
    $$
    select parent_organisation.ghgr_import_id from swrs_transform.address
    join swrs_transform.parent_organisation
    on (
    address.ghgr_import_id = parent_organisation.ghgr_import_id
    and address.parent_organisation_idx = parent_organisation.parent_organisation_idx)
    and address.type='ParentOrganisation'
    and address.parent_organisation_idx = 0
    $$,

    'select ghgr_import_id from swrs_transform.parent_organisation where parent_organisation.parent_organisation_idx= 0',

    'Foreign keys ghgr_import_id, parent_organisation_idx, in ggircs_swrs_address reference swrs_transform.parent_organisation'
);


-- test the columnns for swrs_transform.address have been properly parsed from xml when context is 'Facility'
select results_eq(
  $$ select ghgr_import_id from swrs_transform.address where address.type='Facility' $$,
  'select id from swrs_extract.ghgr_import',
  'swrs_transform.address parsed column ghgr_import_id'
);

select results_eq(
  $$ select type from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Facility'::varchar],
  'swrs_transform.address parsed column type'
);
select results_eq(
  $$ select swrs_facility_id from swrs_transform.address where address.type='Facility' $$,
  ARRAY[666::integer],
  'swrs_transform.address parsed column swrs_facility_id'
);
-- test that the swrs_organisation_id is null when getting address from the context of facility
select results_eq(
  $$ select swrs_organisation_id from swrs_transform.address where address.type='Facility' $$,
  ARRAY[null::integer],
  'swrs_transform.address parsed column swrs_organisation_id'
);

-- Physical Address columns
select results_eq(
  $$ select physical_address_unit_number from swrs_transform.address where address.type='Facility' $$,
  ARRAY[1::varchar],
  'swrs_transform.address parsed column physical_address_unit_number'
);
select results_eq(
  $$ select physical_address_street_number from swrs_transform.address where address.type='Facility' $$,
  ARRAY[1234::varchar],
  'swrs_transform.address parsed column physical_address_street_number'
);
select results_eq(
  $$ select physical_address_street_number_suffix from swrs_transform.address where address.type='Facility' $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column physical_address_street_number_suffix'
);
select results_eq(
  $$ select physical_address_street_name from swrs_transform.address where address.type='Facility' $$,
  ARRAY['00th'::varchar],
  'swrs_transform.address parsed column physical_address_municipality'
);
select results_eq(
  $$ select physical_address_street_type from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Avenue'::varchar],
  'swrs_transform.address parsed column physical_address_street_type'
);
select results_eq(
  $$ select physical_address_street_direction from swrs_transform.address where address.type='Facility' $$,
  ARRAY['NW'::varchar],
  'swrs_transform.address parsed column physical_address_street_direction'
);
select results_eq(
  $$ select physical_address_municipality from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Fort Nelson'::varchar],
  'swrs_transform.address parsed column physical_address_municipality'
);
select results_eq(
  $$ select physical_address_prov_terr_state from swrs_transform.address where address.type='Facility' $$,
  ARRAY['British Columbia'::varchar],
  'swrs_transform.address parsed column physical_address_prov_terr_state'
);
select results_eq(
  $$ select physical_address_postal_code_zip_code from swrs_transform.address where address.type='Facility' $$,
  ARRAY['H0H 0H0'::varchar],
  'swrs_transform.address parsed column physical_address_postal_code_zip_code'
);
select results_eq(
  $$ select physical_address_country from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column physical_address_country'
);
select results_eq(
  $$ select physical_address_national_topographical_description from swrs_transform.address where address.type='Facility' $$,
  ARRAY['A-123-B/456-C-00'::varchar],
  'swrs_transform.address parsed column physical_address_national_topographical_description'
);
select results_eq(
  $$ select physical_address_additional_information from swrs_transform.address where address.type='Facility' $$,
  ARRAY['INFO'::varchar],
  'swrs_transform.address parsed column physical_address_additional_information'
);
select results_eq(
  $$ select physical_address_land_survey_description from swrs_transform.address where address.type='Facility' $$,
  ARRAY['OOH shiny!'::varchar],
  'swrs_transform.address parsed column physical_address_land_survey_description'
);

-- Mailing Address Columns
select results_eq(
  $$ select mailing_address_delivery_mode from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Post Office Box'::varchar],
  'swrs_transform.address parsed column mailing_address_delivery_mode'
);
select results_eq(
  $$ select mailing_address_po_box_number from swrs_transform.address where address.type='Facility' $$,
  ARRAY['0000'::varchar],
  'swrs_transform.address parsed column mailing_address_po_box_number'
);
select results_eq(
  $$ select mailing_address_unit_number from swrs_transform.address where address.type='Facility' $$,
  ARRAY['1'::varchar],
  'swrs_transform.address parsed column mailing_address_unit_number'
);
select results_eq(
  $$ select mailing_address_rural_route_number from swrs_transform.address where address.type='Facility' $$,
  ARRAY['321'::varchar],
  'swrs_transform.address parsed column mailing_address_rural_route_number'
);
select results_eq(
  $$ select mailing_address_street_number from swrs_transform.address where address.type='Facility' $$,
  ARRAY[1234::varchar],
  'swrs_transform.address parsed column mailing_address_street_number'
);
select results_eq(
  $$ select mailing_address_street_number_suffix from swrs_transform.address where address.type='Facility' $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column mailing_address_street_number_suffix'
);
select results_eq(
  $$ select mailing_address_street_name from swrs_transform.address where address.type='Facility' $$,
  ARRAY['00th'::varchar],
  'swrs_transform.address parsed column mailing_address_street_name'
);
select results_eq(
  $$ select mailing_address_street_type from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Avenue'::varchar],
  'swrs_transform.address parsed column mailing_address_street_type'
);
select results_eq(
  $$ select mailing_address_street_direction from swrs_transform.address where address.type='Facility' $$,
  ARRAY['West'::varchar],
  'swrs_transform.address parsed column mailing_address_street_direction'
);
select results_eq(
  $$ select mailing_address_municipality from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Fort Nelson'::varchar],
  'swrs_transform.address parsed column mailing_address_municipality'
);
select results_eq(
  $$ select mailing_address_prov_terr_state from swrs_transform.address where address.type='Facility' $$,
  ARRAY['British Columbia'::varchar],
  'swrs_transform.address parsed column mailing_address_prov_terr_state'
);
select results_eq(
  $$ select mailing_address_postal_code_zip_code from swrs_transform.address where address.type='Facility' $$,
  ARRAY['H0H 0H0'::varchar],
  'swrs_transform.address parsed column mailing_address_postal_code_zip_code'
);
select results_eq(
  $$ select mailing_address_country from swrs_transform.address where address.type='Facility' $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column mailing_address_country'
);
select results_eq(
  $$ select mailing_address_additional_information from swrs_transform.address where address.type='Facility' $$,
  ARRAY['The site is located at A-123-B-456-C-789'::varchar],
  'swrs_transform.address parsed column mailing_address_additional_information'
);

-- Geographic Address columns
select results_eq(
  $$ select geographic_address_latitude from swrs_transform.address where address.type='Facility' $$,
  ARRAY[23.45125::numeric],
  'swrs_transform.address parsed column geographic_address_latitude'
);
select results_eq(
  $$ select geographic_address_longitude from swrs_transform.address where address.type='Facility' $$,
  ARRAY[-90.59062::numeric],
  'swrs_transform.address parsed column geographic_address_longitude'
);

-- Test Organisation Columns

-- test the columnns for swrs_transform.address have been properly parsed from xml when context is 'Organisation'
select results_eq(
  $$ select ghgr_import_id from swrs_transform.address where address.type='Organisation' $$,
  'select id from swrs_extract.ghgr_import',
  'swrs_transform.address parsed column ghgr_import_id'
);
select results_eq(
  $$ select type from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Organisation'::varchar],
  'swrs_transform.address parsed column type'
);
-- test that the swrs_facility_id is null when getting address from the context of organisation
select results_eq(
  $$ select swrs_facility_id from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[null::integer],
  'swrs_transform.address parsed column swrs_organisation_id'
);

select results_eq(
  $$ select swrs_organisation_id from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[123::integer],
  'swrs_transform.address parsed column swrs_organisation_id'
);

-- Physical Address columns
select results_eq(
  $$ select physical_address_unit_number from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[4321::varchar],
  'swrs_transform.address parsed column physical_address_unit_number'
);
select results_eq(
  $$ select physical_address_street_number from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[100::varchar],
  'swrs_transform.address parsed column physical_address_street_number'
);
select results_eq(
  $$ select physical_address_street_number_suffix from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column physical_address_street_number_suffix'
);
select results_eq(
  $$ select physical_address_street_name from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['111th Street West'::varchar],
  'swrs_transform.address parsed column physical_address_street_name'
);
select results_eq(
  $$ select physical_address_street_type from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Street'::varchar],
  'swrs_transform.address parsed column physical_address_street_type'
);
select results_eq(
  $$ select physical_address_street_direction from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['West'::varchar],
  'swrs_transform.address parsed column physical_address_street_direction'
);
select results_eq(
  $$ select physical_address_municipality from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Funkytown'::varchar],
  'swrs_transform.address parsed column physical_address_municipality'
);
select results_eq(
  $$ select physical_address_prov_terr_state from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Funky'::varchar],
  'swrs_transform.address parsed column physical_address_prov_terr_state'
);
select results_eq(
  $$ select physical_address_postal_code_zip_code from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['H0H0H0'::varchar],
  'swrs_transform.address parsed column physical_address_postal_code_zip_code'
);
select results_eq(
  $$ select physical_address_country from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column physical_address_country'
);
select results_eq(
  $$ select physical_address_national_topographical_description from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['A-123-B/456-C-00'::varchar],
  'swrs_transform.address parsed column physical_address_national_topographical_description'
);
select results_eq(
  $$ select physical_address_additional_information from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['INFO'::varchar],
  'swrs_transform.address parsed column physical_address_additional_information'
);
select results_eq(
  $$ select physical_address_land_survey_description from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['OOH shiny!'::varchar],
  'swrs_transform.address parsed column physical_address_land_survey_description'
);

-- Mailing Address Columns
select results_eq(
  $$ select mailing_address_delivery_mode from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['General Delivery'::varchar],
  'swrs_transform.address parsed column mailing_address_delivery_mode'
);
select results_eq(
  $$ select mailing_address_po_box_number from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['0000'::varchar],
  'swrs_transform.address parsed column mailing_address_po_box_number'
);
select results_eq(
  $$ select mailing_address_unit_number from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['00'::varchar],
  'swrs_transform.address parsed column mailing_address_unit_number'
);
select results_eq(
  $$ select mailing_address_rural_route_number from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['321'::varchar],
  'swrs_transform.address parsed column mailing_address_rural_route_number'
);
select results_eq(
  $$ select mailing_address_street_number from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[100::varchar],
  'swrs_transform.address parsed column mailing_address_street_number'
);
select results_eq(
  $$ select mailing_address_street_number_suffix from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['B'::varchar],
  'swrs_transform.address parsed column mailing_address_street_number_suffix'
);
select results_eq(
  $$ select mailing_address_street_name from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['111th Street West'::varchar],
  'swrs_transform.address parsed column mailing_address_street_name'
);
select results_eq(
  $$ select mailing_address_street_type from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Street'::varchar],
  'swrs_transform.address parsed column mailing_address_street_type'
);
select results_eq(
  $$ select mailing_address_street_direction from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['West'::varchar],
  'swrs_transform.address parsed column mailing_address_street_direction'
);
select results_eq(
  $$ select mailing_address_municipality from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Funkytown'::varchar],
  'swrs_transform.address parsed column mailing_address_municipality'
);
select results_eq(
  $$ select mailing_address_prov_terr_state from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Funky'::varchar],
  'swrs_transform.address parsed column mailing_address_prov_terr_state'
);
select results_eq(
  $$ select mailing_address_postal_code_zip_code from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['H0H0H0'::varchar],
  'swrs_transform.address parsed column mailing_address_postal_code_zip_code'
);
select results_eq(
  $$ select mailing_address_country from swrs_transform.address where address.type='Organisation' $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column mailing_address_country'
);
select results_eq(
  $$ select mailing_address_additional_information from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column mailing_address_additional_information'
);

-- Geographic Address columns
select results_eq(
  $$ select geographic_address_latitude from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[23.45125::numeric],
  'swrs_transform.address parsed column geographic_address_latitude'
);
select results_eq(
  $$ select geographic_address_longitude from swrs_transform.address where address.type='Organisation' $$,
  ARRAY[-90.59062::numeric],
  'swrs_transform.address parsed column geographic_address_longitude'
);

-- Test Contact Columns

-- test the columnns for swrs_transform.address have been properly parsed from xml when context is 'Contact'
select results_eq(
  $$ select ghgr_import_id from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  'select id from swrs_extract.ghgr_import',
  'swrs_transform.address parsed column ghgr_import_id'
);
select results_eq(
  $$ select type from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Contact'::varchar],
  'swrs_transform.address parsed column type'
);

select results_eq(
  $$ select swrs_facility_id from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY[666::integer],
  'swrs_transform.address parsed column swrs_contact_id'
);

-- test that the swrs_organisation_id is null when getting address from the context of contact
select results_eq(
  $$ select swrs_organisation_id from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY[null::integer],
  'swrs_transform.address parsed column swrs_organisation_id'
);

-- Physical Address columns
select results_eq(
  $$ select physical_address_unit_number from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY[1::varchar],
  'swrs_transform.address parsed column physical_address_unit_number'
);
select results_eq(
  $$ select physical_address_street_number from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY[1234::varchar],
  'swrs_transform.address parsed column physical_address_street_number'
);
select results_eq(
  $$ select physical_address_street_number_suffix from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column physical_address_street_number_suffix'
);
select results_eq(
  $$ select physical_address_street_name from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['00th'::varchar],
  'swrs_transform.address parsed column physical_address_municipality'
);
select results_eq(
  $$ select physical_address_street_type from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Avenue'::varchar],
  'swrs_transform.address parsed column physical_address_street_type'
);
select results_eq(
  $$ select physical_address_street_direction from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['NW'::varchar],
  'swrs_transform.address parsed column physical_address_street_direction'
);
select results_eq(
  $$ select physical_address_municipality from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Fort Nelson'::varchar],
  'swrs_transform.address parsed column physical_address_municipality'
);
select results_eq(
  $$ select physical_address_prov_terr_state from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['British Columbia'::varchar],
  'swrs_transform.address parsed column physical_address_prov_terr_state'
);
select results_eq(
  $$ select physical_address_postal_code_zip_code from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['H0H 0H0'::varchar],
  'swrs_transform.address parsed column physical_address_postal_code_zip_code'
);
select results_eq(
  $$ select physical_address_country from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column physical_address_country'
);
select results_eq(
  $$ select physical_address_national_topographical_description from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['A-123-B/456-C-00'::varchar],
  'swrs_transform.address parsed column physical_address_national_topographical_description'
);
select results_eq(
  $$ select physical_address_additional_information from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['INFO'::varchar],
  'swrs_transform.address parsed column physical_address_additional_information'
);
select results_eq(
  $$ select physical_address_land_survey_description from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['OOH shiny!'::varchar],
  'swrs_transform.address parsed column physical_address_land_survey_description'
);

-- Mailing Address Columns
select results_eq(
  $$ select mailing_address_delivery_mode from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Post Office Box'::varchar],
  'swrs_transform.address parsed column mailing_address_delivery_mode'
);
select results_eq(
  $$ select mailing_address_po_box_number from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['0000'::varchar],
  'swrs_transform.address parsed column mailing_address_po_box_number'
);
select results_eq(
  $$ select mailing_address_unit_number from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['1'::varchar],
  'swrs_transform.address parsed column mailing_address_unit_number'
);
select results_eq(
  $$ select mailing_address_rural_route_number from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['321'::varchar],
  'swrs_transform.address parsed column mailing_address_rural_route_number'
);
select results_eq(
  $$ select mailing_address_street_number from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY[1234::varchar],
  'swrs_transform.address parsed column mailing_address_street_number'
);
select results_eq(
  $$ select mailing_address_street_number_suffix from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column mailing_address_street_number_suffix'
);
select results_eq(
  $$ select mailing_address_street_name from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['00th'::varchar],
  'swrs_transform.address parsed column mailing_address_street_name'
);
select results_eq(
  $$ select mailing_address_street_type from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Avenue'::varchar],
  'swrs_transform.address parsed column mailing_address_street_type'
);
select results_eq(
  $$ select mailing_address_street_direction from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['West'::varchar],
  'swrs_transform.address parsed column mailing_address_street_direction'
);
select results_eq(
  $$ select mailing_address_municipality from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Fort Nelson'::varchar],
  'swrs_transform.address parsed column mailing_address_municipality'
);
select results_eq(
  $$ select mailing_address_prov_terr_state from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['British Columbia'::varchar],
  'swrs_transform.address parsed column mailing_address_prov_terr_state'
);
select results_eq(
  $$ select mailing_address_postal_code_zip_code from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['H0H 0H0'::varchar],
  'swrs_transform.address parsed column mailing_address_postal_code_zip_code'
);
select results_eq(
  $$ select mailing_address_country from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column mailing_address_country'
);
select results_eq(
  $$ select mailing_address_additional_information from swrs_transform.address where address.type='Contact' and address.contact_idx=0 $$,
  ARRAY['The site is located at A-123-B-456-C-789'::varchar],
  'swrs_transform.address parsed column mailing_address_additional_information'
);

-- Test parent_organisation Columns

-- test the columnns for swrs_transform.address have been properly parsed from xml when context is 'ParentOrganisation'
select results_eq(
  $$ select ghgr_import_id from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  'select id from swrs_extract.ghgr_import',
  'swrs_transform.address parsed column ghgr_import_id'
);
select results_eq(
  $$ select type from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['ParentOrganisation'::varchar],
  'swrs_transform.address parsed column type'
);
select results_eq(
  $$ select swrs_facility_id from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY[null::integer],
  'swrs_transform.address parsed column swrs_parent_organisation_id'
);
-- test that the swrs_organisation_id is null when getting address from the context of parent_organisation
select results_eq(
  $$ select swrs_organisation_id from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY[123::integer],
  'swrs_transform.address parsed column swrs_organisation_id'
);

-- Physical Address columns
select results_eq(
  $$ select physical_address_unit_number from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY[1::varchar],
  'swrs_transform.address parsed column physical_address_unit_number'
);
select results_eq(
  $$ select physical_address_street_number from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY[1234::varchar],
  'swrs_transform.address parsed column physical_address_street_number'
);
select results_eq(
  $$ select physical_address_street_number_suffix from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column physical_address_street_number_suffix'
);
select results_eq(
  $$ select physical_address_street_name from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['00th'::varchar],
  'swrs_transform.address parsed column physical_address_municipality'
);
select results_eq(
  $$ select physical_address_street_type from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['Avenue'::varchar],
  'swrs_transform.address parsed column physical_address_street_type'
);
select results_eq(
  $$ select physical_address_street_direction from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['NW'::varchar],
  'swrs_transform.address parsed column physical_address_street_direction'
);
select results_eq(
  $$ select physical_address_municipality from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['Fort Nelson'::varchar],
  'swrs_transform.address parsed column physical_address_municipality'
);
select results_eq(
  $$ select physical_address_prov_terr_state from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['British Columbia'::varchar],
  'swrs_transform.address parsed column physical_address_prov_terr_state'
);
select results_eq(
  $$ select physical_address_postal_code_zip_code from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['H0H 0H0'::varchar],
  'swrs_transform.address parsed column physical_address_postal_code_zip_code'
);
select results_eq(
  $$ select physical_address_country from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column physical_address_country'
);
select results_eq(
  $$ select physical_address_national_topographical_description from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['A-123-B/456-C-00'::varchar],
  'swrs_transform.address parsed column physical_address_national_topographical_description'
);
select results_eq(
  $$ select physical_address_additional_information from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['INFO'::varchar],
  'swrs_transform.address parsed column physical_address_additional_information'
);
select results_eq(
  $$ select physical_address_land_survey_description from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['OOH shiny!'::varchar],
  'swrs_transform.address parsed column physical_address_land_survey_description'
);

-- Mailing Address Columns
select results_eq(
  $$ select mailing_address_delivery_mode from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['Post Office Box'::varchar],
  'swrs_transform.address parsed column mailing_address_delivery_mode'
);
select results_eq(
  $$ select mailing_address_po_box_number from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['0000'::varchar],
  'swrs_transform.address parsed column mailing_address_po_box_number'
);
select results_eq(
  $$ select mailing_address_unit_number from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['1'::varchar],
  'swrs_transform.address parsed column mailing_address_unit_number'
);
select results_eq(
  $$ select mailing_address_rural_route_number from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['321'::varchar],
  'swrs_transform.address parsed column mailing_address_rural_route_number'
);
select results_eq(
  $$ select mailing_address_street_number from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY[1234::varchar],
  'swrs_transform.address parsed column mailing_address_street_number'
);
select results_eq(
  $$ select mailing_address_street_number_suffix from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY[null::varchar],
  'swrs_transform.address parsed column mailing_address_street_number_suffix'
);
select results_eq(
  $$ select mailing_address_street_name from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['00th'::varchar],
  'swrs_transform.address parsed column mailing_address_street_name'
);
select results_eq(
  $$ select mailing_address_street_type from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['Avenue'::varchar],
  'swrs_transform.address parsed column mailing_address_street_type'
);
select results_eq(
  $$ select mailing_address_street_direction from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['West'::varchar],
  'swrs_transform.address parsed column mailing_address_street_direction'
);
select results_eq(
  $$ select mailing_address_municipality from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['Fort Nelson'::varchar],
  'swrs_transform.address parsed column mailing_address_municipality'
);
select results_eq(
  $$ select mailing_address_prov_terr_state from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['British Columbia'::varchar],
  'swrs_transform.address parsed column mailing_address_prov_terr_state'
);
select results_eq(
  $$ select mailing_address_postal_code_zip_code from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['H0H 0H0'::varchar],
  'swrs_transform.address parsed column mailing_address_postal_code_zip_code'
);
select results_eq(
  $$ select mailing_address_country from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['Canada'::varchar],
  'swrs_transform.address parsed column mailing_address_country'
);
select results_eq(
  $$ select mailing_address_additional_information from swrs_transform.address where address.type='ParentOrganisation' and address.parent_organisation_idx=0 $$,
  ARRAY['The site is located at A-123-B-456-C-789'::varchar],
  'swrs_transform.address parsed column mailing_address_additional_information'
);

select finish();
rollback;
