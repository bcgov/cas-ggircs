-- Verify ggircs:view_pro_rated_carbon_rate on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views where table_schema='swrs' and table_name='pro_rated_carbon_tax_rate')) then
      raise exception 'swrs.pro_rated_carbon_tax_rate exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
