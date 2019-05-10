set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(42);

select has_materialized_view(
    'ggircs_swrs', 'contact',
    'ggircs_swrs.contact should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'contact', 'ggircs_contact_primary_key',
    'ggircs_swrs.contact should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'contact'::name, array[
    'ghgr_import_id'::name,
    'path_context'::name,
    'contact_idx'::name,
    'contact_type'::name,
    'given_name'::name,
    'family_name'::name,
    'initials'::name,
    'telephone_number'::name,
    'extension_number'::name,
    'fax_number'::name,
    'email_address'::name,
    'position'::name,
    'language_correspondence'::name
]);

select col_type_is(      'ggircs_swrs', 'contact', 'ghgr_import_id', 'integer', 'contact.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'contact', 'ghgr_import_id', 'contact.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'contact', 'path_context', 'contact.path_context column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'path_context', 'character varying(1000)', 'contact.path_context column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'path_context', 'contact.path_context column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'path_context', 'contact.path_context column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'contact_idx', 'contact.contact_idx column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'contact_idx', 'integer', 'contact.contact_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'contact', 'contact_idx', 'contact.contact_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'contact_idx', 'contact.contact_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'contact_type', 'contact.contact_type column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'contact_type', 'character varying(1000)', 'contact.contact_type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'contact_type', 'contact.contact_type column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'contact_type', 'contact.contact_type column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'given_name', 'contact.given_name column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'given_name', 'character varying(1000)', 'contact.given_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'given_name', 'contact.given_name column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'given_name', 'contact.given_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'family_name', 'contact.family_name column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'family_name', 'character varying(1000)', 'contact.family_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'family_name', 'contact.family_name column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'family_name', 'contact.family_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'initials', 'contact.initials column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'initials', 'character varying(1000)', 'contact.initials column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'initials', 'contact.initials column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'initials', 'contact.initials column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'telephone_number', 'contact.telephone_number column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'telephone_number', 'character varying(1000)', 'contact.telephone_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'telephone_number', 'contact.telephone_number column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'telephone_number', 'contact.telephone_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'extension_number', 'contact.extension_number column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'extension_number', 'character varying(1000)', 'contact.extension_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'extension_number', 'contact.extension_number column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'extension_number', 'contact.extension_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'fax_number', 'contact.fax_number column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'fax_number', 'character varying(1000)', 'contact.fax_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'fax_number', 'contact.fax_number column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'fax_number', 'contact.fax_number column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'email_address', 'contact.email_address column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'email_address', 'character varying(1000)', 'contact.email_address column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'email_address', 'contact.email_address column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'email_address', 'contact.email_address column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'position', 'contact.position column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'position', 'character varying(1000)', 'contact.position column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'position', 'contact.position column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'position', 'contact.position column should not have a default');

--  select has_column(       'ggircs_swrs', 'contact', 'language_correspondence', 'contact.language_correspondence column should exist');
select col_type_is(      'ggircs_swrs', 'contact', 'language_correspondence', 'character varying(1000)', 'contact.language_correspondence column should be type varchar');
select col_is_null(      'ggircs_swrs', 'contact', 'language_correspondence', 'contact.language_correspondence column should not allow null');
select col_hasnt_default('ggircs_swrs', 'contact', 'language_correspondence', 'contact.language_correspondence column should not have a default');

-- XML fixture for testing
insert into ggircs_swrs.ghgr_import (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Contacts>
      <Contact>
        <Details>
          <ContactType>Operator Contact</ContactType>
          <GivenName>Simon</GivenName>
          <FamilyName>Belmont</FamilyName>
          <TelephoneNumber>1233456789</TelephoneNumber>
          <FaxNumber>987654321</FaxNumber>
          <EmailAddress>dead@vampires.com</EmailAddress>
          <Position>Vampire Hunter</Position>
          <LanguageCorrespondence>English</LanguageCorrespondence>
        </Details>
      </Contact>
    </Contacts>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
  </ReportDetails>
</ReportData>
$$);

refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.contact with data;

--  Test ghgr_import_id fk relation
select results_eq(
   'select facility.ghgr_import_id from ggircs_swrs.contact ' ||
   'join ggircs_swrs.facility ' ||
   'on ' ||
   'contact.ghgr_import_id =  facility.ghgr_import_id ',

   'select ghgr_import_id from ggircs_swrs.facility',

   'Foreign key ghgr_import_id in ggircs_swrs_contact references ggircs_swrs.facility'
);

-- TODO: tests on the veracity of what is being pulled in to this view from xml

select * from finish();
rollback;
