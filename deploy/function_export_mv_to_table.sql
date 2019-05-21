-- Deploy ggircs:function_export_mv_to_table to pg
-- requires:
  -- table_ghgr_import materialized_view_report materialized_view_final_report
  -- materialized_view_facility materialized_view_organisation
  -- materialized_view_address materialized_view_contact
  -- materialized_view_naics materialized_view_identifier
  -- materialized_view_permit materialized_view_parent_organisation
  -- materialized_view_activity materialized_view_unit materialized_view_fuel
  -- materialized_view_emission materialized_view_descriptor

-- select ggircs_swrs.export_mv_to_table();

begin;

create or replace function ggircs_swrs.export_mv_to_table()
  returns void as
$$
  /** Create all tables from materialized views that are not being split up **/
  declare

       mv_array text[] := '{report, organisation, ' ||
                       'activity, unit, identifier, naics, ' ||
                       'final_report, fuel, permit, parent_organisation, contact, ' ||
                       'address, descriptor}';

  begin
    for i in 1 .. array_upper(mv_array, 1)
      loop

        raise notice 'Exporting: %', mv_array[i];

        execute
          'drop table if exists ggircs.' || quote_ident(mv_array[i]) || ' cascade';
        -- execute 'refresh materialized view ggircs_swrs.' || mv_array[i] || ' with data';
        execute
          'create table ggircs.' || quote_ident(mv_array[i]) ||
                ' as (select x.* from ggircs_swrs.' || quote_ident(mv_array[i]) ||
                ' as x inner join ggircs_swrs.final_report as final_report ' ||
                ' on x.ghgr_import_id = final_report.ghgr_import_id)';
        -- execute 'refresh materialized view ggircs_swrs.' || mv_array[i] || ' with no data';
        execute
          'alter table ggircs.' || quote_ident(mv_array[i]) ||
          ' add column id int generated always as identity primary key';

      end loop;


    /** ggircs_swrs.emission split into: ggircs.non_attributable_emission && ggircs_attributable_emission **/
    raise notice 'Exporting non_attributable_emission';

    execute
      'drop table if exists ggircs.non_attributable_emission';

    execute
      'create table ggircs.non_attributable_emission ' ||
      'as (select x.* from ggircs_swrs.emission ' ||
      'as x inner join ggircs_swrs.final_report as final_report ' ||
      'on x.ghgr_import_id = final_report.ghgr_import_id ' ||
      'join ggircs_swrs.facility as facility ' ||
      'on x.ghgr_import_id = facility.ghgr_import_id ' ||
      'and (x.gas_type = ''CO2bioC'' ' ||
      'or facility.facility_type = ''EIO'' ))';

    execute 'alter table ggircs.non_attributable_emission add column id int generated always as identity primary key';

    raise notice 'Exporting attributable_emission';

    execute
      'drop table if exists ggircs.attributable_emission';

    execute
      'create table ggircs.attributable_emission ' ||
      'as (select x.* from ggircs_swrs.emission ' ||
      'as x inner join ggircs_swrs.final_report as final_report ' ||
      'on x.ghgr_import_id = final_report.ghgr_import_id ' ||
      'join ggircs_swrs.facility as facility ' ||
      'on x.ghgr_import_id = facility.ghgr_import_id ' ||
      'and x.gas_type != ''CO2bioC'' '
      'and facility.facility_type != ''EIO'' )';

    execute 'alter table ggircs.attributable_emission add column id int generated always as identity primary key';

    /** ggircs_swrs.facility split into: ggircs.lfo_facility && ggircs.single_facility**/
    raise notice 'Exporting lfo_facility';

    execute
      'drop table if exists ggircs.lfo_facility';

    execute
      'create table ggircs.lfo_facility ' ||
      'as (select x.* from ggircs_swrs.facility ' ||
      'as x inner join ggircs_swrs.final_report as final_report ' ||
      'on x.ghgr_import_id = final_report.ghgr_import_id ' ||
      'and x.facility_type = ''LFO'' )';

    execute 'alter table ggircs.lfo_facility add column id int generated always as identity primary key';
    
    raise notice 'Exporting single_facility';

    execute
      'drop table if exists ggircs.single_facility';

    execute
      'create table ggircs.single_facility ' ||
      'as (select x.* from ggircs_swrs.facility ' ||
      'as x inner join ggircs_swrs.final_report as final_report ' ||
      'on x.ghgr_import_id = final_report.ghgr_import_id ' ||
      'and x.facility_type != ''LFO'' )';

    execute 'alter table ggircs.single_facility add column id int generated always as identity primary key';

    /** Create additional_reportable_activity table**/
    raise notice 'Exporting additional_reportable_activity';

    execute
      'drop table if exists ggircs.additional_reportable_activity';

    execute
      'create table ggircs.additional_reportable_activity ' ||
      'as (select x.* from ggircs_swrs.activity ' ||
      'as x inner join ggircs_swrs.final_report as final_report ' ||
      'on x.ghgr_import_id = final_report.ghgr_import_id ' ||
      'and x.sub_process_name in  (''Additional Reportable Information as per WCI.352(i)(1)-(12)'',' ||
                                   '''Additional Reportable Information as per WCI.352(i)(13)'', ' ||
                                   '''Additional Reportable Information as per WCI.362(g)(21)'', ' ||
                                   '''Additional information for cement and lime production facilities only (not aggregated in totals)'', ' ||
                                   '''Additional information for cement and lime production facilities only (not aggregated intotals)'', ' ||
                                   '''Additional information required when other activities selected are Activities in Table 2 rows 2, 4, 5 , or 6'', ' ||
                                   '''Additional reportable information'') )';

    execute 'alter table ggircs.additional_reportable_activity add column id int generated always as identity primary key';

    /** NON-Attributable Emission FKs**/
      -- Create FK/PK relation between Non-Attributable_Emission and Activity
      alter table ggircs.non_attributable_emission add column activity_id int;
      create index ggircs_non_attributable_emission_activity_index on ggircs.non_attributable_emission (activity_id);
      update ggircs.non_attributable_emission set activity_id = activity.id from ggircs.activity
          where non_attributable_emission.ghgr_import_id = activity.ghgr_import_id
            and non_attributable_emission.process_idx = activity.process_idx
            and non_attributable_emission.sub_process_idx = activity.sub_process_idx
            and non_attributable_emission.activity_name = activity.activity_name;
      alter table ggircs.non_attributable_emission add constraint ggircs_non_attributable_emission_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Non-Attributable_Emission and Fuel
      alter table ggircs.non_attributable_emission add column fuel_id int;
      create index ggircs_non_attributable_emission_fuel_index on ggircs.non_attributable_emission (fuel_id);
      update ggircs.non_attributable_emission set fuel_id = fuel.id from ggircs.fuel
          where non_attributable_emission.ghgr_import_id = fuel.ghgr_import_id 
            and non_attributable_emission.process_idx = fuel.process_idx  
            and non_attributable_emission.sub_process_idx = fuel.sub_process_idx
            and non_attributable_emission.activity_name = fuel.activity_name  
            and non_attributable_emission.sub_activity_name = fuel.sub_activity_name  
            and non_attributable_emission.unit_name = fuel.unit_name
            and non_attributable_emission.sub_unit_name = fuel.sub_unit_name 
            and non_attributable_emission.substance_idx = fuel.substance_idx 
            and non_attributable_emission.substances_idx = fuel.substances_idx
            and non_attributable_emission.sub_unit_name = fuel.sub_unit_name
            and non_attributable_emission.units_idx = fuel.units_idx 
            and non_attributable_emission.unit_idx = fuel.unit_idx
            and non_attributable_emission.fuel_idx = fuel.fuel_idx;
      alter table ggircs.non_attributable_emission add constraint ggircs_non_attributable_emission_fuel_foreign_key foreign key (fuel_id) references ggircs.fuel(id);

      -- Create FK/PK relation between Non-Attributable_Emission and NAICS
      alter table ggircs.non_attributable_emission add column naics_id int;
      create index ggircs_non_attributable_emission_naics_index on ggircs.non_attributable_emission (naics_id);
      update ggircs.non_attributable_emission set naics_id = naics.id from ggircs.naics
          where non_attributable_emission.ghgr_import_id = naics.ghgr_import_id
          and naics.path_context = 'RegistrationData';
      alter table ggircs.non_attributable_emission add constraint ggircs_non_attributable_emission_naics_foreign_key foreign key (naics_id) references ggircs.naics(id);

      -- Create FK/PK relation between Non-Attributable_Emission and Organisation
      alter table ggircs.non_attributable_emission add column organisation_id int;
      create index ggircs_non_attributable_emission_organisation_index on ggircs.non_attributable_emission (organisation_id);
      update ggircs.non_attributable_emission set organisation_id = organisation.id from ggircs.organisation
          where non_attributable_emission.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.non_attributable_emission add constraint ggircs_non_attributable_emission_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

      -- Create FK/PK relation between Non-Attributable_Emission and Report
      alter table ggircs.non_attributable_emission add column report_id int;
      create index ggircs_non_attributable_emission_report_index on ggircs.non_attributable_emission (report_id);
      update ggircs.non_attributable_emission set report_id = report.id from ggircs.report
          where non_attributable_emission.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.non_attributable_emission add constraint ggircs_non_attributable_emission_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Non-Attributable_Emission and Unit
      alter table ggircs.non_attributable_emission add column unit_id int;
      create index ggircs_non_attributable_emission_unit_index on ggircs.non_attributable_emission (unit_id);
      update ggircs.non_attributable_emission set unit_id = unit.id from ggircs.unit
          where non_attributable_emission.ghgr_import_id = unit.ghgr_import_id 
            and non_attributable_emission.process_idx = unit.process_idx  
            and non_attributable_emission.sub_process_idx = unit.sub_process_idx
            and non_attributable_emission.activity_name = unit.activity_name
            and non_attributable_emission.units_idx = unit.units_idx 
            and non_attributable_emission.unit_idx = unit.unit_idx;
      alter table ggircs.non_attributable_emission add constraint ggircs_non_attributable_emission_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);

    /** Attributable Emission FKs**/
      -- Create FK/PK relation between Attributable_Emission and Activity
      alter table ggircs.attributable_emission add column activity_id int;
      create index ggircs_attributable_emission_activity_index on ggircs.attributable_emission (activity_id);
      update ggircs.attributable_emission set activity_id = activity.id from ggircs.activity
          where attributable_emission.ghgr_import_id = activity.ghgr_import_id
            and attributable_emission.process_idx = activity.process_idx
            and attributable_emission.sub_process_idx = activity.sub_process_idx
            and attributable_emission.activity_name = activity.activity_name;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Attributable_Emission and Fuel
      alter table ggircs.attributable_emission add column fuel_id int;
      create index ggircs_attributable_emission_fuel_index on ggircs.attributable_emission (fuel_id);
      update ggircs.attributable_emission set fuel_id = fuel.id from ggircs.fuel
          where attributable_emission.ghgr_import_id = fuel.ghgr_import_id 
            and attributable_emission.process_idx = fuel.process_idx  
            and attributable_emission.sub_process_idx = fuel.sub_process_idx
            and attributable_emission.activity_name = fuel.activity_name  
            and attributable_emission.sub_activity_name = fuel.sub_activity_name  
            and attributable_emission.unit_name = fuel.unit_name
            and attributable_emission.sub_unit_name = fuel.sub_unit_name 
            and attributable_emission.substance_idx = fuel.substance_idx 
            and attributable_emission.substances_idx = fuel.substances_idx
            and attributable_emission.sub_unit_name = fuel.sub_unit_name
            and attributable_emission.units_idx = fuel.units_idx 
            and attributable_emission.unit_idx = fuel.unit_idx
            and attributable_emission.fuel_idx = fuel.fuel_idx;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_fuel_foreign_key foreign key (fuel_id) references ggircs.fuel(id);

      -- Create FK/PK relation between Attributable_Emission and NAICS
      alter table ggircs.attributable_emission add column naics_id int;
      create index ggircs_attributable_emission_naics_index on ggircs.attributable_emission (naics_id);
      update ggircs.attributable_emission set naics_id = naics.id from ggircs.naics
          where attributable_emission.ghgr_import_id = naics.ghgr_import_id
          and naics.path_context = 'RegistrationData';
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_naics_foreign_key foreign key (naics_id) references ggircs.naics(id);

      -- Create FK/PK relation between Attributable_Emission and Organisation
      alter table ggircs.attributable_emission add column organisation_id int;
      create index ggircs_attributable_emission_organisation_index on ggircs.attributable_emission (organisation_id);
      update ggircs.attributable_emission set organisation_id = organisation.id from ggircs.organisation
          where attributable_emission.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

      -- Create FK/PK relation between Attributable_Emission and Report
      alter table ggircs.attributable_emission add column report_id int;
      create index ggircs_attributable_emission_report_index on ggircs.attributable_emission (report_id);
      update ggircs.attributable_emission set report_id = report.id from ggircs.report
          where attributable_emission.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_report_foreign_key foreign key (report_id) references ggircs.report(id);
      
      -- Create FK/PK relation between Attributable_Emission and Unit
      alter table ggircs.attributable_emission add column unit_id int;
      create index ggircs_attributable_emission_unit_index on ggircs.attributable_emission (unit_id);
      update ggircs.attributable_emission set unit_id = unit.id from ggircs.unit
          where attributable_emission.ghgr_import_id = unit.ghgr_import_id 
            and attributable_emission.process_idx = unit.process_idx  
            and attributable_emission.sub_process_idx = unit.sub_process_idx
            and attributable_emission.activity_name = unit.activity_name
            and attributable_emission.units_idx = unit.units_idx 
            and attributable_emission.unit_idx = unit.unit_idx;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);

    /** LFO FACILITY FKs**/
      -- Create FK/PK relation between Attributable_Emission and Facility
      alter table ggircs.attributable_emission add column lfo_facility_id int;
      create index ggircs_attributable_emission_lfo_facility_index on ggircs.attributable_emission (lfo_facility_id);
      update ggircs.attributable_emission set lfo_facility_id = lfo_facility.id from ggircs.lfo_facility
          where attributable_emission.ghgr_import_id = lfo_facility.ghgr_import_id;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_lfo_facility_foreign_key foreign key (lfo_facility_id) references ggircs.lfo_facility(id);

      -- Create FK/PK relation between Facility and Report
      alter table ggircs.lfo_facility add column report_id int;
      create index ggircs_lfo_facility_report_index on ggircs.lfo_facility (report_id);
      update ggircs.lfo_facility set report_id = report.id from ggircs.report
          where lfo_facility.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.lfo_facility add constraint ggircs_lfo_facility_report_foreign_key foreign key (report_id) references ggircs.report(id);

     -- Create FK/PK relation between Address and Facility
      alter table ggircs.address add column lfo_facility_id int;
      create index ggircs_address_lfo_facility_index on ggircs.address (lfo_facility_id);
      update ggircs.address set lfo_facility_id = lfo_facility.id from ggircs.lfo_facility
          where address.ghgr_import_id = lfo_facility.ghgr_import_id
          and address.type = 'Facility';
      alter table ggircs.address add constraint ggircs_address_lfo_facility_foreign_key foreign key (lfo_facility_id) references ggircs.lfo_facility(id);

     -- Create FK/PK relation between Contact and Facility
      alter table ggircs.contact add column lfo_facility_id int;
      create index ggircs_contact_lfo_facility_index on ggircs.contact (lfo_facility_id);
      update ggircs.contact set lfo_facility_id = lfo_facility.id from ggircs.lfo_facility
          where contact.ghgr_import_id = lfo_facility.ghgr_import_id;
      alter table ggircs.contact add constraint ggircs_contact_lfo_facility_foreign_key foreign key (lfo_facility_id) references ggircs.lfo_facility(id);

      -- Create FK/PK relation between Identifier and Facility
      alter table ggircs.identifier add column lfo_facility_id int;
      create index ggircs_identifier_lfo_facility_index on ggircs.identifier (lfo_facility_id);
      update ggircs.identifier set lfo_facility_id = lfo_facility.id from ggircs.lfo_facility
          where identifier.ghgr_import_id = lfo_facility.ghgr_import_id;
      alter table ggircs.identifier add constraint ggircs_identifier_lfo_facility_foreign_key foreign key (lfo_facility_id) references ggircs.lfo_facility(id);

      -- Create FK/PK relation between NAICS and Facility
      alter table ggircs.naics add column lfo_facility_id int;
      create index ggircs_naics_lfo_facility_index on ggircs.naics (lfo_facility_id);
      update ggircs.naics set lfo_facility_id = lfo_facility.id from ggircs.lfo_facility
          where naics.ghgr_import_id = lfo_facility.ghgr_import_id;
      alter table ggircs.naics add constraint ggircs_naics_lfo_facility_foreign_key foreign key (lfo_facility_id) references ggircs.lfo_facility(id);

      -- Create FK/PK relation between Permit and Facility
      alter table ggircs.permit add column lfo_facility_id int;
      create index ggircs_permit_lfo_facility_index on ggircs.permit (lfo_facility_id);
      update ggircs.permit set lfo_facility_id = lfo_facility.id from ggircs.lfo_facility
          where permit.ghgr_import_id = lfo_facility.ghgr_import_id;
      alter table ggircs.permit add constraint ggircs_permit_lfo_facility_foreign_key foreign key (lfo_facility_id) references ggircs.lfo_facility(id);

      -- Create FK/PK relation between Activity and Facility
      alter table ggircs.activity add column lfo_facility_id int;
      create index ggircs_activity_lfo_facility_index on ggircs.activity (lfo_facility_id);
      update ggircs.activity set lfo_facility_id = lfo_facility.id from ggircs.lfo_facility
          where activity.ghgr_import_id = lfo_facility.ghgr_import_id;
      alter table ggircs.activity add constraint ggircs_activity_lfo_facility_foreign_key foreign key (lfo_facility_id) references ggircs.lfo_facility(id);

      -- Create FK/PK relation between Facility and Organisation
      alter table ggircs.lfo_facility add column organisation_id int;
      create index ggircs_lfo_facility_organisation_index on ggircs.lfo_facility (organisation_id);
      update ggircs.lfo_facility set organisation_id = organisation.id from ggircs.organisation
          where lfo_facility.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.lfo_facility add constraint ggircs_lfo_facility_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

    /** SINGLE FACILITY FKs **/
      -- Create FK/PK relation between Non-Attributable_Emission and Facility
      alter table ggircs.non_attributable_emission add column single_facility_id int;
      create index ggircs_non_attributable_emission_single_facility_index on ggircs.non_attributable_emission (single_facility_id);
      update ggircs.non_attributable_emission set single_facility_id = single_facility.id from ggircs.single_facility
          where non_attributable_emission.ghgr_import_id = single_facility.ghgr_import_id;
      alter table ggircs.non_attributable_emission add constraint ggircs_non_attributable_emission_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);

      -- Create FK/PK relation between Attributable_Emission and Facility
      alter table ggircs.attributable_emission add column single_facility_id int;
      create index ggircs_attributable_emission_facility_index on ggircs.attributable_emission (single_facility_id);
      update ggircs.attributable_emission set single_facility_id = single_facility.id from ggircs.single_facility
          where attributable_emission.ghgr_import_id = single_facility.ghgr_import_id;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);

      -- Create FK/PK relation between Facility and Report
      alter table ggircs.single_facility add column report_id int;
      create index ggircs_single_facility_report_index on ggircs.single_facility (report_id);
      update ggircs.single_facility set report_id = report.id from ggircs.report
          where single_facility.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.single_facility add constraint ggircs_single_facility_report_foreign_key foreign key (report_id) references ggircs.report(id);

     -- Create FK/PK relation between Address and Facility
      alter table ggircs.address add column single_facility_id int;
      create index ggircs_address_single_facility_index on ggircs.address (single_facility_id);
      update ggircs.address set single_facility_id = single_facility.id from ggircs.single_facility
          where address.ghgr_import_id = single_facility.ghgr_import_id
          and address.type = 'Facility';
      alter table ggircs.address add constraint ggircs_address_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);

     -- Create FK/PK relation between Contact and Facility
      alter table ggircs.contact add column single_facility_id int;
      create index ggircs_contact_single_facility_index on ggircs.contact (single_facility_id);
      update ggircs.contact set single_facility_id = single_facility.id from ggircs.single_facility
          where contact.ghgr_import_id = single_facility.ghgr_import_id;
      alter table ggircs.contact add constraint ggircs_contact_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);

      -- Create FK/PK relation between Identifier and Facility
      alter table ggircs.identifier add column single_facility_id int;
      create index ggircs_identifier_single_facility_index on ggircs.identifier (single_facility_id);
      update ggircs.identifier set single_facility_id = single_facility.id from ggircs.single_facility
          where identifier.ghgr_import_id = single_facility.ghgr_import_id;
      alter table ggircs.identifier add constraint ggircs_identifier_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);

      -- Create FK/PK relation between NAICS and Facility
      alter table ggircs.naics add column single_facility_id int;
      create index ggircs_naics_single_facility_index on ggircs.naics (single_facility_id);
      update ggircs.naics set single_facility_id = single_facility.id from ggircs.single_facility
          where naics.ghgr_import_id = single_facility.ghgr_import_id;
      alter table ggircs.naics add constraint ggircs_naics_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);

      -- Create FK/PK relation between Permit and Facility
      alter table ggircs.permit add column single_facility_id int;
      create index ggircs_permit_single_facility_index on ggircs.permit (single_facility_id);
      update ggircs.permit set single_facility_id = single_facility.id from ggircs.single_facility
          where permit.ghgr_import_id = single_facility.ghgr_import_id;
      alter table ggircs.permit add constraint ggircs_permit_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);

      -- Create FK/PK relation between Activity and Facility
      alter table ggircs.activity add column single_facility_id int;
      create index ggircs_activity_single_facility_index on ggircs.activity (single_facility_id);
      update ggircs.activity set single_facility_id = single_facility.id from ggircs.single_facility
          where activity.ghgr_import_id = single_facility.ghgr_import_id;
      alter table ggircs.activity add constraint ggircs_activity_single_facility_foreign_key foreign key (single_facility_id) references ggircs.single_facility(id);
      
      -- Create FK/PK relation between Facility and Organisation
      alter table ggircs.single_facility add column organisation_id int;
      create index ggircs_single_facility_organisation_index on ggircs.single_facility (organisation_id);
      update ggircs.single_facility set organisation_id = organisation.id from ggircs.organisation
          where single_facility.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.single_facility add constraint ggircs_single_facility_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

    /** Remaining FK's **/
      -- Create FK/PK relation between Activity and Report
      alter table ggircs.activity add column report_id int;
      create index ggircs_activity_report_index on ggircs.activity (report_id);
      update ggircs.activity set report_id = report.id from ggircs.report
          where activity.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.activity add constraint ggircs_activity_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Address and Organisation
      alter table ggircs.address add column organisation_id int;
      create index ggircs_address_organisation_index on ggircs.address (organisation_id);
      update ggircs.address set organisation_id = organisation.id from ggircs.organisation
          where address.ghgr_import_id = organisation.ghgr_import_id
          and address.type = 'Organisation';
      alter table ggircs.address add constraint ggircs_address_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

      -- Create FK/PK relation between Address and parent_organisation
      alter table ggircs.address add column parent_organisation_id int;
      create index ggircs_address_parent_organisation_index on ggircs.address (parent_organisation_id);
      update ggircs.address set parent_organisation_id = parent_organisation.id from ggircs.parent_organisation
        where address.ghgr_import_id = parent_organisation.ghgr_import_id
      and address.type = 'ParentOrganisation'
      and address.parent_organisation_idx = parent_organisation.parent_organisation_idx;
      alter table ggircs.address add constraint ggircs_address_parent_organisation_foreign_key foreign key (parent_organisation_id) references ggircs.parent_organisation(id);

      -- Create FK/PK relation between Contact and Address
      alter table ggircs.contact add column address_id int;
      create index ggircs_contact_address_index on ggircs.contact (address_id);
      update ggircs.contact set address_id = address.id from ggircs.address
          where address.ghgr_import_id = contact.ghgr_import_id
          and   address.type = 'Contact'
          and   address.contact_idx = contact.contact_idx;
      alter table ggircs.contact add constraint ggircs_contact_address_foreign_key foreign key (address_id) references ggircs.address(id);

      -- Create FK/PK relation between Descriptor and Activity
      alter table ggircs.descriptor add column activity_id int;
      create index ggircs_descriptor_activity_index on ggircs.descriptor (activity_id);
      update ggircs.descriptor set activity_id = activity.id from ggircs.activity
          where descriptor.ghgr_import_id = activity.ghgr_import_id
            and descriptor.process_idx = activity.process_idx
            and descriptor.sub_process_idx = activity.sub_process_idx
            and descriptor.activity_name = activity.activity_name;
      alter table ggircs.descriptor add constraint ggircs_descriptor_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Fuel and Unit
      alter table ggircs.fuel add column unit_id int;
      create index ggircs_fuel_unit_index on ggircs.fuel (unit_id);
      update ggircs.fuel set unit_id = unit.id from ggircs.unit
          where fuel.ghgr_import_id = unit.ghgr_import_id and fuel.process_idx = unit.process_idx  and fuel.sub_process_idx = unit.sub_process_idx
            and fuel.activity_name = unit.activity_name and fuel.units_idx = unit.units_idx and fuel.unit_idx = unit.unit_idx;
      alter table ggircs.fuel add constraint ggircs_fuel_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);

    -- Create FK/PK relation between Organisation and Parent Organisation
      alter table ggircs.organisation add column parent_organisation_id int;
      create index ggircs_organisation_parent_organisation_index on ggircs.organisation (parent_organisation_id);
      update ggircs.organisation set parent_organisation_id = parent_organisation.id from ggircs.parent_organisation
          where parent_organisation.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.organisation add constraint ggircs_organisation_parent_organisation_foreign_key foreign key (parent_organisation_id) references ggircs.parent_organisation(id);

      -- Create FK/PK relation between Unit and Activity
      alter table ggircs.unit add column activity_id int;
      create index ggircs_unit_activity_index on ggircs.unit (activity_id);
      update ggircs.unit set activity_id = activity.id from ggircs.activity
          where unit.ghgr_import_id = activity.ghgr_import_id
            and unit.process_idx = activity.process_idx
            and unit.sub_process_idx = activity.sub_process_idx
            and unit.activity_name = activity.activity_name;
      alter table ggircs.unit add constraint ggircs_unit_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

  end;

$$ language plpgsql volatile ;

commit;
