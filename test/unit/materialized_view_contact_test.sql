set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(51);

select has_materialized_view(
    'swrs_transform', 'contact',
    'swrs_transform.contact should be a materialized view'
);

select has_index(
    'swrs_transform', 'contact', 'ggircs_contact_primary_key',
    'swrs_transform.contact should have a primary key'
);

select columns_are('swrs_transform'::name, 'contact'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
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

select col_type_is(      'swrs_transform', 'contact', 'eccc_xml_file_id', 'integer', 'contact.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'contact', 'eccc_xml_file_id', 'contact.eccc_xml_file_id column should not have a default value');

--  select has_column(       'swrs_transform', 'contact', 'path_context', 'contact.path_context column should exist');
select col_type_is(      'swrs_transform', 'contact', 'path_context', 'character varying(1000)', 'contact.path_context column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'path_context', 'contact.path_context column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'path_context', 'contact.path_context column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'contact_idx', 'contact.contact_idx column should exist');
select col_type_is(      'swrs_transform', 'contact', 'contact_idx', 'integer', 'contact.contact_idx column should be type integer');
select col_is_null(      'swrs_transform', 'contact', 'contact_idx', 'contact.contact_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'contact_idx', 'contact.contact_idx column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'contact_type', 'contact.contact_type column should exist');
select col_type_is(      'swrs_transform', 'contact', 'contact_type', 'character varying(1000)', 'contact.contact_type column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'contact_type', 'contact.contact_type column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'contact_type', 'contact.contact_type column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'given_name', 'contact.given_name column should exist');
select col_type_is(      'swrs_transform', 'contact', 'given_name', 'character varying(1000)', 'contact.given_name column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'given_name', 'contact.given_name column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'given_name', 'contact.given_name column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'family_name', 'contact.family_name column should exist');
select col_type_is(      'swrs_transform', 'contact', 'family_name', 'character varying(1000)', 'contact.family_name column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'family_name', 'contact.family_name column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'family_name', 'contact.family_name column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'initials', 'contact.initials column should exist');
select col_type_is(      'swrs_transform', 'contact', 'initials', 'character varying(1000)', 'contact.initials column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'initials', 'contact.initials column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'initials', 'contact.initials column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'telephone_number', 'contact.telephone_number column should exist');
select col_type_is(      'swrs_transform', 'contact', 'telephone_number', 'character varying(1000)', 'contact.telephone_number column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'telephone_number', 'contact.telephone_number column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'telephone_number', 'contact.telephone_number column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'extension_number', 'contact.extension_number column should exist');
select col_type_is(      'swrs_transform', 'contact', 'extension_number', 'character varying(1000)', 'contact.extension_number column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'extension_number', 'contact.extension_number column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'extension_number', 'contact.extension_number column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'fax_number', 'contact.fax_number column should exist');
select col_type_is(      'swrs_transform', 'contact', 'fax_number', 'character varying(1000)', 'contact.fax_number column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'fax_number', 'contact.fax_number column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'fax_number', 'contact.fax_number column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'email_address', 'contact.email_address column should exist');
select col_type_is(      'swrs_transform', 'contact', 'email_address', 'character varying(1000)', 'contact.email_address column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'email_address', 'contact.email_address column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'email_address', 'contact.email_address column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'position', 'contact.position column should exist');
select col_type_is(      'swrs_transform', 'contact', 'position', 'character varying(1000)', 'contact.position column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'position', 'contact.position column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'position', 'contact.position column should not have a default');

--  select has_column(       'swrs_transform', 'contact', 'language_correspondence', 'contact.language_correspondence column should exist');
select col_type_is(      'swrs_transform', 'contact', 'language_correspondence', 'character varying(1000)', 'contact.language_correspondence column should be type varchar');
select col_is_null(      'swrs_transform', 'contact', 'language_correspondence', 'contact.language_correspondence column should not allow null');
select col_hasnt_default('swrs_transform', 'contact', 'language_correspondence', 'contact.language_correspondence column should not have a default');

-- XML fixture for testing
insert into swrs_extract.eccc_xml_file (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Contacts>
      <Contact>
        <Details>
          <ContactType>Operator Contact</ContactType>
          <GivenName>Simon</GivenName>
          <FamilyName>Belmont</FamilyName>
          <TelephoneNumber>123456789</TelephoneNumber>
          <FaxNumber>987654321</FaxNumber>
          <ExtensionNumber>1</ExtensionNumber>
          <EmailAddress>dead@vampires.com</EmailAddress>
          <Position>Vampire Hunter</Position>
          <LanguageCorrespondence>english</LanguageCorrespondence>
        </Details>
      </Contact>
      <Contact>
        <GivenName>RedHerring</GivenName>
      </Contact>
    </Contacts>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
  </ReportDetails>
</ReportData>
$$);

refresh materialized view swrs_transform.facility with data;
refresh materialized view swrs_transform.contact with data;

--  Test eccc_xml_file_id fk relation
select results_eq(
   $$
   select facility.eccc_xml_file_id from swrs_transform.contact
   join swrs_transform.facility
   on
   contact.eccc_xml_file_id =  facility.eccc_xml_file_id
   and contact.contact_idx=0
   $$,

   'select eccc_xml_file_id from swrs_transform.facility',

   'Foreign key eccc_xml_file_id in ggircs_swrs_contact references swrs_transform.facility'
);

-- TODO: tests on the veracity of what is being pulled in to this view from xml
-- Test the xml imports for swrs_transform.contact
select results_eq(
    'select contact_type from swrs_transform.contact where contact_idx=0',
    ARRAY['Operator Contact'::varchar],
    'Column contact_type in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select given_name from swrs_transform.contact where contact_idx=0',
    ARRAY['Simon'::varchar],
    'Column given_name in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select family_name from swrs_transform.contact where contact_idx=0',
    ARRAY['Belmont'::varchar],
    'Column family_name in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select telephone_number from swrs_transform.contact where contact_idx=0',
    ARRAY['123456789'::varchar],
    'Column telephone_number in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select fax_number from swrs_transform.contact where contact_idx=0',
    ARRAY['987654321'::varchar],
    'Column fax_number in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select extension_number from swrs_transform.contact where contact_idx=0',
    ARRAY['1'::varchar],
    'Column extension_number in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select email_address from swrs_transform.contact where contact_idx=0',
    ARRAY['dead@vampires.com'::varchar],
    'Column email_address in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select position from swrs_transform.contact where contact_idx=0',
    ARRAY['Vampire Hunter'::varchar],
    'Column position in swrs_transform.contact has correctly parsed the xml'
);

select results_eq(
    'select language_correspondence from swrs_transform.contact where contact_idx=0',
    ARRAY['english'::varchar],
    'Column language_correspondence in swrs_transform.contact has correctly parsed the xml'
);

select * from finish();
rollback;
