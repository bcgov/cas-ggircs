-- Deploy ggircs:swrs/utility/mutations/create_fuel_mapping_cascade to pg
-- requires: swrs/public/table/fuel
-- requires: swrs/utility/schema

begin;

create or replace function swrs_utility.create_fuel_mapping_cascade(fuel_type_input text, fuel_carbon_tax_details_id_input int)
returns swrs.fuel_mapping
as $function$
declare
  new_id int;
  return_value record;
begin

    -- Add a new fuel_mapping record from the function parameters
    insert into swrs.fuel_mapping(fuel_type, fuel_carbon_tax_details_id) values ($1, $2) returning id into new_id;

    -- Use the id returned from the insert above to update all swrs.fuel fuel_mapping_id columns with the id of the newly inserted record
    update swrs.fuel set fuel_mapping_id = new_id where fuel_type = $1;

    -- Return the newly inserted fuel_mapping record
    select * from swrs.fuel_mapping where id = new_id into return_value;

    return return_value;

end;
$function$ language plpgsql strict volatile;

grant execute on function swrs_utility.create_fuel_mapping_cascade to ggircs_user;

commit;

