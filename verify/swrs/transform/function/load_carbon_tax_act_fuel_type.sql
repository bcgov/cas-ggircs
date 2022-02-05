-- Verify ggircs:swrs/transform/function/load_carbon_tax_act_fuel_type on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_carbon_tax_act_fuel_type')) then
      raise exception 'load_carbon_tax_act_fuel_type() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
