-- Deploy ggircs:swrs/parameters/mutations/create_fuel_mapping_cascade to pg
-- requires: swrs/parameters/schema
-- requires: swrs/parameters/table/fuel_mapping
-- requires: swrs/public/table/fuel

begin;

create or replace function ggircs_parameters.create_fuel_mapping_cascade(fuel_type_input text, fuel_carbon_tax_detail_id_input int)
returns ggircs_parameters.fuel_mapping
as $function$
declare
  new_id int;
  return_value record;
begin

    -- Add a new fuel_mapping record from the function parameters
    insert into ggircs_parameters.fuel_mapping(fuel_type, fuel_carbon_tax_detail_id) values ($1, $2) returning id into new_id;

    -- Use the id returned from the insert above to update all swrs.fuel fuel_mapping_id columns with the id of the newly inserted record
    update swrs.fuel set fuel_mapping_id = new_id where fuel_type = $1;

    -- Return the newly inserted fuel_mapping record
    select * from ggircs_parameters.fuel_mapping where id = new_id into return_value;

    return return_value;

end;
$function$ language plpgsql strict volatile;

grant execute on function ggircs_parameters.create_fuel_mapping_cascade to ggircs_user;

commit;
