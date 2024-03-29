-- Verify ggircs:view_facility_details on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views where table_schema='swrs' and table_name='facility_details')) then
      perform true;
    else
      raise exception 'swrs.facility_details does not exist';
    end if;

  end; $$;

rollback;
