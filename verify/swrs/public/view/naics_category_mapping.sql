-- Verify ggircs:view_naics_mapping on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views where table_schema='swrs' and table_name='naics_category_mapping')) then
      raise exception 'swrs.naics_category_mapping exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
