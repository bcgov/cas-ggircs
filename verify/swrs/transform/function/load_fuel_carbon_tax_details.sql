-- Verify ggircs:swrs/transform/function/load_fuel_carbon_tax_details on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_fuel_carbon_tax_details')) then
      raise exception 'load_fuel_carbon_tax_details() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
