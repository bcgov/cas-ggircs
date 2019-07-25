-- Deploy ggircs:function_transform to pg
-- requires: table_ghgr_import

begin;

-- @data string (with or without data)
create or replace function swrs_transform.transform(data text)
  returns void as
$function$

    declare
      row record;

begin
  -- Refresh views with data
  for row in select matviewname from pg_matviews where schemaname = 'swrs_transform'
      loop
        if row.matviewname != 'flat' then
          execute format('refresh materialized view swrs_transform.%s %s', row.matviewname, data);
        end if;
        raise notice '[%] Transformed %...', timeofday()::timestamp, row.matviewname;
      end loop;


end

$function$ language plpgsql volatile ;

comment on function swrs_transform.transform is 'Refreshes all the materialized views in the swrs_transform schema.';

commit;
