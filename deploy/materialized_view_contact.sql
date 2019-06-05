-- Deploy ggircs:materialized_view_contact to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.contact as (
  select row_number() over () as id, id as ghgr_import_id, contact_details.*
  from ggircs_swrs.ghgr_import,
       xmltable(
           '//Contact[not(ancestor::ConfidentialityRequest)]'
           passing xml_file
           columns
                path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
                contact_idx integer path 'string(count(./ancestor-or-self::Contact/preceding-sibling::Contact))' not null,
                contact_type varchar(1000) path './Details/ContactType[normalize-space(.)]',
                given_name varchar(1000) path './Details/GivenName[normalize-space(.)]',
                family_name varchar(1000) path './Details/FamilyName[normalize-space(.)]',
                initials varchar(1000) path './Details/Initials[normalize-space(.)]',
                telephone_number varchar(1000) path './Details/TelephoneNumber[normalize-space(.)]',
                extension_number varchar(1000) path './Details/ExtensionNumber[normalize-space(.)]',
                fax_number varchar(1000) path './Details/FaxNumber[normalize-space(.)]',
                email_address varchar(1000) path './Details/EmailAddress[normalize-space(.)]',
                position varchar(1000) path './Details/Position[normalize-space(.)]',
                language_correspondence varchar(1000) path './Details/LanguageCorrespondence[normalize-space(.)]'
         ) as contact_details
) with no data;

create unique index ggircs_contact_primary_key
    on ggircs_swrs.contact (ghgr_import_id, path_context, contact_idx);

comment on materialized view ggircs_swrs.contact is 'The materialized view housing contact information';
comment on column ggircs_swrs.contact.id is 'A generated index used for keying in the ggircs schema';
comment on column ggircs_swrs.contact.ghgr_import_id is 'The foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.contact.path_context is 'The umbrella context from which the contact was pulled from the xml (VerifyTombstone or RegistrationData';
comment on column ggircs_swrs.contact.contact_idx is 'The number of preceding Contact siblings before this Contact node';
comment on column ggircs_swrs.contact.contact_type is 'The type of contact';
comment on column ggircs_swrs.contact.given_name is 'The given name of the contact';
comment on column ggircs_swrs.contact.family_name is 'The family name of the contact';
comment on column ggircs_swrs.contact.initials is 'The initials of the contact';
comment on column ggircs_swrs.contact.telephone_number is 'The phone number attached to this contact';
comment on column ggircs_swrs.contact.extension_number is 'The extension number attached to this contact';
comment on column ggircs_swrs.contact.fax_number is 'The fax number attached to this contact';
comment on column ggircs_swrs.contact.email_address is 'The email address attached to this contact';
comment on column ggircs_swrs.contact.position is 'The position of this contact';
comment on column ggircs_swrs.contact.language_correspondence is 'The language of correspondence for thsi contact';

commit;

