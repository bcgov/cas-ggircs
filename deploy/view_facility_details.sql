-- Deploy ggircs:view_facility_details to pg
-- requires: schema_ggircs
-- requires: table_facility
-- requires: table_organisation
-- requires: table_naics
-- requires: table_naics_mapping
-- requires: table_identifier

begin;

create or replace view ggircs.facility_details as
select
       _facility.*,
       _naics.id as naics_id,
       _naics.naics_classification,
       _naics.naics_code,
       _identifier.identifier_value

from ggircs.facility as _facility
       left join ggircs.organisation as _organisation on _facility.organisation_id = _organisation.id
       left join ggircs.naics as _naics on _facility.id = _naics.registration_data_facility_id
       left join ggircs.identifier as _identifier on _facility.id = _identifier.facility_bcghgid_id;

commit;
