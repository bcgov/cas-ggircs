-- Deploy ggircs:view_facility_details to pg
-- requires: schema_ggircs
-- requires: table_facility
-- requires: table_organisation
-- requires: table_naics
-- requires: table_naics_mapping
-- requires: table_identifier

begin;

drop view swrs.facility_details;

commit;
