-- Deploy ggircs:swrs/add_missing_indices to pg

-- Deploy ggircs-portal:database_functions/add_missing_indices to pg

begin;

/** Add an index for every foreign key in the swrs, swrs_extract or swrs_transform schemas that does not have one **/

-- swrs_extract.eccc_xml_file
create index if not exists eccc_xml_file_zip_file_idx
  on swrs_extract.eccc_xml_file(zip_file_id);

-- swrs.emission
create index if not exists emission_fuel_mapping_idx
  on swrs.emission(fuel_mapping_id);

-- swrs.naics
create index if not exists naics_reg_data_facility_idx
  on swrs.naics(registration_data_facility_id);

-- swrs.permit
create index if not exists permit_report_idx
  on swrs.permit(report_id);

commit;
