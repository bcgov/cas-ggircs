-- Deploy ggircs:view_facility_details to pg
-- requires: schema_ggircs
-- requires: table_facility
-- requires: table_organisation
-- requires: table_naics
-- requires: table_naics_mapping
-- requires: table_identifier

begin;

create or replace view ggircs_swrs_load.facility_details as
select
       _facility.*,
       _naics.id as naics_id,
       _naics_category_hhw.naics_category as hhw_category,
       _naics_category_irc.naics_category as irc_category,
       _naics.naics_classification,
       _naics.naics_code,
       _identifier.identifier_value

from ggircs_swrs_load.facility as _facility
       left join ggircs_swrs_load.organisation as _organisation on _facility.organisation_id = _organisation.id
       left join ggircs_swrs_load.naics as _naics on _facility.id = _naics.registration_data_facility_id
       left join ggircs_swrs_load.identifier as _identifier on _facility.id = _identifier.facility_bcghgid_id
       left join ggircs_swrs_load.naics_category_mapping as _naics_category_hhw
           on _naics_category_hhw.naics_code = _naics.naics_code
           and _naics_category_hhw.naics_category_type = 'hhw'
           and _naics_category_hhw.facility_id = _naics.registration_data_facility_id
       left join ggircs_swrs_load.naics_category_mapping as _naics_category_irc
           on _naics_category_irc.naics_code = _naics.naics_code
           and _naics_category_irc.naics_category_type = 'irc'
           and _naics_category_irc.facility_id = _naics.registration_data_facility_id;
commit;
