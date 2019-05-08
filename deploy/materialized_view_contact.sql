-- Deploy ggircs:materialized_view_contact to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.contact as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by ghgr_import_id asc
  )
  select ghgr_import_id, contact_details.*
  from x,
       xmltable(
           '//Contact[not(ancestor::ConfidentialityRequest)]'
           passing source_xml
           columns
                swrs_facility_id numeric(1000,0) path './ancestor-or-self::Contact/ancestor::ReportData/ReportDetails/FacilityId[normalize-space(.)]',
                path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
                contact_idx integer path 'string(count(./ancestor-or-self::Contact/preceding-sibling::Contact))' not null,
                contact_type varchar(1000) path './Details/ContactType[normalize-space(.)]',
                given_name varchar(1000) path './Details/GivenName[normalize-space(.)]',
                telephone_number varchar(1000) path './Details/TelephoneNumber[normalize-space(.)]',
                email_address varchar(1000) path './Details/EmailAddress[normalize-space(.)]',
                position varchar(1000) path './Details/Position[normalize-space(.)]'

         ) as contact_details
) with no data;

create unique index ggircs_contact_primary_key
    on ggircs_swrs.contact (ghgr_import_id, path_context, swrs_facility_id, contact_idx);

comment on materialized view ggircs_swrs.contact is 'The materialized view housing contact information';
comment on column ggircs_swrs.contact.swrs_facility_id is 'The facility id according to the swrs report';
comment on column ggircs_swrs.contact.path_context is 'The umbrella context from which the contact was pulled from the xml (VerifyTombstone or RegistrationData';
comment on column ggircs_swrs.contact.contact_idx is 'The number of preceding Contact siblings before this Contact node';
comment on column ggircs_swrs.contact.contact_type is 'The type of contact';
comment on column ggircs_swrs.contact.given_name is 'The given name of the contact';
comment on column ggircs_swrs.contact.telephone_number is 'The phone number attached to this contact';
comment on column ggircs_swrs.contact.email_address is 'The email address attached to this contact';
comment on column ggircs_swrs.contact.position is 'The position of this contact';

commit;

