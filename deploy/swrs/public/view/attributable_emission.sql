-- Deploy ggircs:view_attributable_emission to pg
-- requires: schema_ggircs

begin;

create or replace view swrs.attributable_emission as(
          select
             row_number() over () as id,
             x.eccc_xml_file_id,
             x.fuel_id,
             x.activity_id,
             x.report_id,
             x.facility_id,
             x.organisation_id,
             x.unit_id,
             x.naics_id,
             x.activity_name,
             x.sub_activity_name,
             x.unit_name,
             x.sub_unit_name,
             x.fuel_name,
             x.emission_type,
             x.gas_type,
             x.methodology,
             x.not_applicable,
             x.quantity,
             x.calculated_quantity,
             x.emission_category

          from swrs.emission as x
          join swrs.facility as _facility
          on x.facility_id = _facility.id
          join swrs.activity as _activity
          on x.activity_id = _activity.id
          and x.gas_type != 'CO2bioC'
          and _facility.facility_type != 'EIO'
          and _facility.facility_type != 'LFO'
          and _activity.sub_process_name not in  ('Additional Reportable Information as per WCI.352(i)(1)-(12)',
                                   'Additional Reportable Information as per WCI.352(i)(13)',
                                   'Additional Reportable Information as per WCI.362(g)(21)',
                                   'Additional information for cement and lime production facilities only (not aggregated in totals)',
                                   'Additional information for cement and lime production facilities only (not aggregated intotals)',
                                   'Additional information required when other activities selected are Activities in Table 2 rows 2, 4, 5 , or 6',
                                   'Additional reportable information')
          );
commit;
