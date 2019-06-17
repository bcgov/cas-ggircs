set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

/** FUEL **/
-- Fuel -> Report
select results_eq(
    $$
        select substring((
            select
                indexdef
            from
                pg_indexes
            where
                schemaname = 'ggircs_swrs'
            and
                tablename = 'report'
            and
                indexname = 'ggircs_report_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id
    $$ select 'ghgr_import_id' $$,

    'All columns in index ggircs_report_primary_key are used in join when creating ggircs.fuel -> ggircs.report FK relation'
);

-- Fuel -> Unit
select results_eq(
    $$
        select substring((
            select
                indexdef
            from
                pg_indexes
            where
                schemaname = 'ggircs_swrs'
            and
                tablename = 'unit'
            and
                indexname = 'ggircs_unit_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id, activity_name, process_idx, sub_process_idx, units_idx, unit_idx
    $$ select 'ghgr_import_id, activity_name, process_idx, sub_process_idx, units_idx, unit_idx' $$,

    'All columns in index ggircs_unit_primary_key are used in join when creating ggircs.fuel -> ggircs.unit FK relation'
);

-- Fuel -> Fuel Mapping (ggircs_swrs)
select results_eq(
    $$
        select substring((
            select
                indexdef
            from
                pg_indexes
            where
                schemaname = 'ggircs_swrs'
            and
                tablename = 'fuel_mapping'
            and
                indexname = 'ggircs_swrs_fuel_mapping_fuel_type')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: fuel_type
    $$ select 'fuel_type' $$,

    'All columns in index ggircs_fuel_mapping_fuel_type are used in join when creating ggircs.fuel -> ggircs.fuel_mapping FK relation'
);

select * from finish();
rollback;
