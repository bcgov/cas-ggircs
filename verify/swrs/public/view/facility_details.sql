-- Verify ggircs:view_facility_details on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views where table_schema='swrs' and table_name='facility_details')) then
      raise exception 'swrs.facility_details exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
