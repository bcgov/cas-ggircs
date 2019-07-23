-- Deploy ggircs:function_load to pg
-- requires:
  -- table_ghgr_import materialized_view_report materialized_view_final_report
  -- materialized_view_facility materialized_view_organisation
  -- materialized_view_address materialized_view_contact
  -- materialized_view_naics materialized_view_identifier
  -- materialized_view_permit materialized_view_parent_organisation
  -- materialized_view_activity materialized_view_unit materialized_view_fuel
  -- materialized_view_emission materialized_view_additional_data

begin;

create or replace function swrs_transform.load(
    refresh_transform boolean default true,
    clear_transform boolean default true
)
  returns void as
$function$

  declare

    mv_array text[] := $$
      {report, organisation, facility,
      activity, unit, identifier, naics, fuel,
      emission, permit, parent_organisation, address,
      contact, additional_data, measured_emission_factor}
      $$;

    view_to_recreate record;
  begin

    -- Refresh materialized views
    if refresh_transform then
        perform swrs_transform.transform('with data');
    end if;

    -- Create the load schema, without records
    drop schema if exists swrs_load cascade;
    raise notice '[%] Creating temporary schema swrs_load...', timeofday()::timestamp;
    perform swrs_transform.clone_schema('ggircs', 'swrs_load', false);

    -- Loop to populate ggircs tables with data from ggircs_swrs
        for i in 1 .. array_upper(mv_array, 1)
      loop
        execute format('select swrs_transform.load_%s()', mv_array[i]);
        raise notice '[%] Loaded %...', timeofday()::timestamp, mv_array[i];
      end loop;

    -- Refresh materialized views with no data
    if clear_transform then
        perform swrs_transform.transform('with no data');
    end if;

    -- Find views from other schemas referencing ggircs
    create temp table views_to_recreate as
    with dependent_view as (
        select dependent_ns.nspname as dependent_schema, dependent_view.relname as view_name
        from pg_depend
                 join pg_rewrite on pg_depend.objid = pg_rewrite.oid
                 join pg_class as dependent_view on pg_rewrite.ev_class = dependent_view.oid
                 join pg_class as source_table on pg_depend.refobjid = source_table.oid
                 join pg_attribute on pg_depend.refobjid = pg_attribute.attrelid
            AND pg_depend.refobjsubid = pg_attribute.attnum
                 join pg_namespace dependent_ns on dependent_ns.oid = dependent_view.relnamespace
                 join pg_namespace source_ns on source_ns.oid = source_table.relnamespace
        where source_ns.nspname = 'ggircs'
          and dependent_ns.nspname != 'ggircs'
        group by dependent_schema, view_name
    )
    select table_name::text, table_schema, view_definition
    from information_schema.views
    join dependent_view
        on views.table_schema = dependent_view.dependent_schema
        and views.table_name = dependent_view.view_name;

    raise notice 'Overriding to the live data schema';
    drop schema if exists swrs cascade;
    alter schema swrs_load rename to ggircs;

    for view_to_recreate in select * from views_to_recreate
    loop
        raise notice 'Recreating view %.%', view_to_recreate.table_schema, view_to_recreate.table_name;
        execute 'create view ' || view_to_recreate.table_schema ||'.'
            || view_to_recreate.table_name || ' as ' || view_to_recreate.view_definition || ';';
    end loop;

    drop table views_to_recreate;

  end;

$function$ language plpgsql volatile ;

commit;
