-- Deploy ggircs:view_facility_details to pg
-- requires: schema_ggircs
-- requires: table_facility
-- requires: table_organisation
-- requires: table_naics
-- requires: table_naics_mapping
-- requires: table_identifier

begin;

create or replace view swrs.facility_details as (
  select
    _facility.*,
    _naics.id as naics_id,
    _naics.naics_classification,
    _naics.naics_code
  from swrs.facility as _facility
    left join swrs.naics as _naics
      on _facility.id = _naics.facility_id
      and _naics.naics_priority = 'Primary'
);

commit;
