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
        execute format('refresh materialized view swrs_transform.%s %s', row.matviewname, data);
        raise notice '[%] Transformed %...', timeofday()::timestamp, row.matviewname;
      end loop;


end

$function$ language plpgsql volatile ;

commit;
