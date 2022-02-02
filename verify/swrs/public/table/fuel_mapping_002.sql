-- Verify ggircs:swrs/public/table/fuel_mapping_002 on pg

begin;

do $$
  begin

    if (select exists (select * from information_schema.key_column_usage where table_name='fuel_mapping' and constraint_name='fuel_carbon_tax_details_foreign_key')) then
      perform true;
    else
      raise exception 'fuel_carbon_tax_details foreign key is missing on fuel_mapping table';
    end if;

  end; $$;

rollback;
