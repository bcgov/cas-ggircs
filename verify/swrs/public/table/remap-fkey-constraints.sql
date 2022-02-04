-- Verify ggircs:swrs/public/table/remap-fkey-constraints on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.constraint_column_usage where table_schema='swrs_utility' and constraint_name = 'emission_fuel_mapping_id_fkey')) then
      perform true;
    else
      raise exception 'swrs_emission is missing the foreign key constraint to swrs_utility.fuel_mapping';
    end if;

    if (select exists(select * from information_schema.constraint_column_usage where table_schema='swrs_utility' and constraint_name = 'fuel_fuel_mapping_id_fkey')) then
      perform true;
    else
      raise exception 'swrs_fuel is missing the foreign key constraint to swrs_utility.fuel_mapping';
    end if;

  end; $$;

rollback;
