set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(15);


-- insert necessary data into table ghgr_import
-- TODO(wenzowski): test VerifyTombstone
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Address>
        <PhysicalAddress>
          <Municipality>Fort Nelson</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H 0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <NationalTopographicalDescription>A-123-B/456-C-00</NationalTopographicalDescription>
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
  </ReportDetails>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs.address with data;

-- test the columnns for ggircs_swrs.facility have been properly parsed from xml
select results_eq(
  'select id from ggircs_swrs.address',
  ARRAY[1::bigint],
  'ggircs_swrs.facility parsed column id'
);
select results_eq(
  'select ghgr_import_id from ggircs_swrs.address',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.address parsed column ghgr_import_id'
);
select results_eq(
  'select facility_id from ggircs_swrs.address',
  ARRAY[666::numeric],
  'ggircs_swrs.address parsed column facility_id'
);
-- test that the organisation_id is null when getting address from the context of facility
select results_eq(
  'select organisation_id from ggircs_swrs.address',
  ARRAY[null::numeric],
  'ggircs_swrs.address parsed column organisation_id'
);
select results_eq(
  'select physical_address_unit_number from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column physical_address_unit_number'
);
select results_eq(
  'select physical_address_street_number from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column physical_address_street_number'
);
select results_eq(
  'select physical_address_street_number_suffix from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column physical_address_street_number_suffix'
);
select results_eq(
  'select physical_address_street_name from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column physical_address_municipality'
);
select results_eq(
  'select physical_address_street_type from ggircs_swrs.address',
  ARRAY[null::varchar],
  'ggircs_swrs.address parsed column physical_address_street_type'
);
select results_eq(
  'select physical_address_street_direction from ggircs_swrs.address',
  ARRAY[null::varchar],
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

select finish();
rollback;
