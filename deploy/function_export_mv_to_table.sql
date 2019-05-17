-- Deploy ggircs:function_export_mv_to_table to pg
-- requires:
  -- table_ghgr_import materialized_view_report materialized_view_final_report
  -- materialized_view_facility materialized_view_organisation
  -- materialized_view_address materialized_view_contact
  -- materialized_view_naics materialized_view_identifier
  -- materialized_view_permit materialized_view_parent_organisation
  -- materialized_view_activity materialized_view_unit materialized_view_fuel
  -- materialized_view_emission materialized_view_descriptor

select ggircs_swrs.export_mv_to_table();

BEGIN;

create or replace function ggircs_swrs.export_mv_to_table()
  returns void as
$$

  declare

    mv_array text[] := '{emission, identifier, final_report, ' ||
                        'address, organisation, fuel, unit, descriptor, activity, ' ||
                        'parent_organisation, contact, ' ||
                        'permit, naics, facility, report}';

  begin
    for i in 1 .. array_upper(mv_array, 1)
      loop

        raise notice 'Exporting: %', mv_array[i];

        execute
          'drop table if exists ggircs.' || quote_ident(mv_array[i]) || '';
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

      -- Create FK/PK relation between Emission and Fuel
      alter table ggircs.emission add column fuel_id int;
      create index ggircs_emission_fuel_index on ggircs.emission (fuel_id);
      update ggircs.emission set fuel_id = fuel.id from ggircs.fuel
          where emission.ghgr_import_id = fuel.ghgr_import_id 
            and emission.process_idx = fuel.process_idx  
            and emission.sub_process_idx = fuel.sub_process_idx
            and emission.activity_name = fuel.activity_name  
            and emission.sub_activity_name = fuel.sub_activity_name  
            and emission.unit_name = fuel.unit_name
            and emission.sub_unit_name = fuel.sub_unit_name 
            and emission.substance_idx = fuel.substance_idx 
            and emission.substances_idx = fuel.substances_idx
            and emission.sub_unit_name = fuel.sub_unit_name
            and emission.units_idx = fuel.units_idx 
            and emission.unit_idx = fuel.unit_idx
            and emission.fuel_idx = fuel.fuel_idx;
      alter table ggircs.emission add constraint ggircs_emission_fuel_foreign_key foreign key (fuel_id) references ggircs.fuel(id);
      
      -- Create FK/PK relation between Emission and Unit
      alter table ggircs.emission add column unit_id int;
      create index ggircs_emission_unit_index on ggircs.emission (unit_id);
      update ggircs.emission set unit_id = unit.id from ggircs.unit
          where emission.ghgr_import_id = unit.ghgr_import_id 
            and emission.process_idx = unit.process_idx  
            and emission.sub_process_idx = unit.sub_process_idx
            and emission.activity_name = unit.activity_name
            and emission.units_idx = unit.units_idx 
            and emission.unit_idx = unit.unit_idx;
      alter table ggircs.emission add constraint ggircs_emission_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);

      -- Create FK/PK relation between Emission and Activity
      alter table ggircs.emission add column activity_id int;
      create index ggircs_emission_activity_index on ggircs.emission (activity_id);
      update ggircs.emission set activity_id = activity.id from ggircs.activity
          where emission.ghgr_import_id = activity.ghgr_import_id 
            and emission.process_idx = activity.process_idx  
            and emission.sub_process_idx = activity.sub_process_idx
            and emission.activity_name = activity.activity_name;
      alter table ggircs.emission add constraint ggircs_emission_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

     -- Create FK/PK relation between Emission and Facility
      alter table ggircs.emission add column facility_id int;
      create index ggircs_emission_facility_index on ggircs.emission (facility_id);
      update ggircs.emission set facility_id = facility.id from ggircs.facility
          where emission.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.emission add constraint ggircs_emission_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);
 
      -- Create FK/PK relation between Emission and Report
      alter table ggircs.emission add column report_id int;
      create index ggircs_emission_report_index on ggircs.emission (report_id);
      update ggircs.emission set report_id = report.id from ggircs.report
          where emission.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.emission add constraint ggircs_emission_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Emission and Organisation
      alter table ggircs.emission add column organisation_id int;
      create index ggircs_emission_organisation_index on ggircs.emission (organisation_id);
      update ggircs.emission set organisation_id = organisation.id from ggircs.organisation
          where emission.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.emission add constraint ggircs_emission_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

      -- Create FK/PK relation between Emission and NAICS
      alter table ggircs.emission add column naics_id int;
      create index ggircs_emission_naics_index on ggircs.emission (naics_id);
      update ggircs.emission set naics_id = naics.id from ggircs.naics
          where emission.ghgr_import_id = naics.ghgr_import_id
          and naics.path_context = 'RegistrationData';
      alter table ggircs.emission add constraint ggircs_emission_naics_foreign_key foreign key (naics_id) references ggircs.naics(id);

      -- Create FK/PK relation between Fuel and Unit
      alter table ggircs.fuel add column unit_id int;
      create index ggircs_fuel_unit_index on ggircs.fuel (unit_id);
      update ggircs.fuel set unit_id = unit.id from ggircs.unit
          where fuel.ghgr_import_id = unit.ghgr_import_id and fuel.process_idx = unit.process_idx  and fuel.sub_process_idx = unit.sub_process_idx
            and fuel.activity_name = unit.activity_name and fuel.units_idx = unit.units_idx and fuel.unit_idx = unit.unit_idx;
      alter table ggircs.fuel add constraint ggircs_fuel_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);

      -- Create FK/PK relation between Unit and Activity
      alter table ggircs.unit add column activity_id int;
      create index ggircs_unit_activity_index on ggircs.unit (activity_id);
      update ggircs.unit set activity_id = activity.id from ggircs.activity
          where unit.ghgr_import_id = activity.ghgr_import_id
            and unit.process_idx = activity.process_idx
            and unit.sub_process_idx = activity.sub_process_idx
            and unit.activity_name = activity.activity_name;
      alter table ggircs.unit add constraint ggircs_unit_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Descriptor and Activity
      alter table ggircs.descriptor add column activity_id int;
      create index ggircs_descriptor_activity_index on ggircs.descriptor (activity_id);
      update ggircs.descriptor set activity_id = activity.id from ggircs.activity
          where descriptor.ghgr_import_id = activity.ghgr_import_id
            and descriptor.process_idx = activity.process_idx
            and descriptor.sub_process_idx = activity.sub_process_idx
            and descriptor.activity_name = activity.activity_name;
      alter table ggircs.descriptor add constraint ggircs_descriptor_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Activity and Facility
      alter table ggircs.activity add column facility_id int;
      create index ggircs_activity_facility_index on ggircs.activity (facility_id);
      update ggircs.activity set facility_id = facility.id from ggircs.facility
          where activity.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.activity add constraint ggircs_activity_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);
 
      -- Create FK/PK relation between Activity and Report
      alter table ggircs.activity add column report_id int;
      create index ggircs_activity_report_index on ggircs.activity (report_id);
      update ggircs.activity set report_id = report.id from ggircs.report
          where activity.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.activity add constraint ggircs_activity_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Facility and Report
      alter table ggircs.facility add column report_id int;
      create index ggircs_facility_report_index on ggircs.facility (report_id);
      update ggircs.facility set report_id = report.id from ggircs.report
          where facility.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.facility add constraint ggircs_facility_report_foreign_key foreign key (report_id) references ggircs.report(id);

     -- Create FK/PK relation between Address and Facility
      alter table ggircs.address add column facility_id int;
      create index ggircs_address_facility_index on ggircs.address (facility_id);
      update ggircs.address set facility_id = facility.id from ggircs.facility
          where address.ghgr_import_id = facility.ghgr_import_id
          and address.type = 'Facility';
      alter table ggircs.address add constraint ggircs_address_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

       -- Create FK/PK relation between Address and Organisation
      alter table ggircs.address add column organisation_id int;
      create index ggircs_address_organisation_index on ggircs.address (organisation_id);
      update ggircs.address set organisation_id = organisation.id from ggircs.organisation
          where address.ghgr_import_id = organisation.ghgr_import_id
          and address.type = 'Organisation';
      alter table ggircs.address add constraint ggircs_address_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

       -- Create FK/PK relation between Address and Parent parent_organisation
      alter table ggircs.address add column parent_organisation_id int;
      create index ggircs_address_parent_organisation_index on ggircs.address (parent_organisation_id);
      update ggircs.address set parent_organisation_id = parent_organisation.id from ggircs.parent_organisation
          where address.ghgr_import_id = parent_organisation.ghgr_import_id
          and address.type = 'ParentOrganisation'
          and address.parent_organisation_idx = parent_organisation.parent_organisation_idx;
      alter table ggircs.address add constraint ggircs_address_parent_organisation_foreign_key foreign key (parent_organisation_id) references ggircs.parent_organisation(id);

      
     -- Create FK/PK relation between Contact and Facility
      alter table ggircs.contact add column facility_id int;
      create index ggircs_contact_facility_index on ggircs.contact (facility_id);
      update ggircs.contact set facility_id = facility.id from ggircs.facility
          where contact.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.contact add constraint ggircs_contact_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);
 

      -- Create FK/PK relation between Identifier and Facility
      alter table ggircs.identifier add column facility_id int;
      create index ggircs_identifier_facility_index on ggircs.identifier (facility_id);
      update ggircs.identifier set facility_id = facility.id from ggircs.facility
          where identifier.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.identifier add constraint ggircs_identifier_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between NAICS and Facility
      alter table ggircs.naics add column facility_id int;
      create index ggircs_naics_facility_index on ggircs.naics (facility_id);
      update ggircs.naics set facility_id = facility.id from ggircs.facility
          where naics.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.naics add constraint ggircs_naics_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);
      
      -- Create FK/PK relation between Permit and Facility
      alter table ggircs.permit add column facility_id int;
      create index ggircs_permit_facility_index on ggircs.permit (facility_id);
      update ggircs.permit set facility_id = facility.id from ggircs.facility
          where permit.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.permit add constraint ggircs_permit_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

/*       -- Create FK/PK relation between Contact and Address
      alter table ggircs.contact add column address_id int;
      create index ggircs_contact_address_index on ggircs.contact (address_id);
      update ggircs.contact set address_id = address.id from ggircs.address
          where address.ghgr_import_id = contact.ghgr_import_id
          and   address.type = 'Contact'
          and   address.contact_idx = contact.contact_idx
      ;
      alter table ggircs.contact add constraint ggircs_contact_address_foreign_key foreign key (address_id) references ggircs.address(id);*/


  end;

$$ language plpgsql volatile ;

COMMIT;
