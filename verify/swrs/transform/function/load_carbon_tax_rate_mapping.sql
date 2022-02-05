-- Verify ggircs:swrs/transform/function/load_carbon_tax_rate_mapping on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_carbon_tax_rate_mappping')) then
      raise exception 'load_carbon_tax_rate_mapping() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
