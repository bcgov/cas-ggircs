set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

/** ACTIVITY **/
-- Activity -> Report
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

    'All columns in unique index ggircs_report_primary_key are used in join when creating ggircs.activity -> ggircs.single_facility FK relation'
);
-- Activity -> Single Facility
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
                tablename = 'facility'
            and
                indexname = 'ggircs_facility_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id
    $$ select 'ghgr_import_id' $$,

    'All columns in unique index ggircs_facility_primary_key are used in join when creating ggircs.activity -> ggircs.single_facility FK relation'
);

-- Activity -> LFO Facility
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
                tablename = 'facility'
            and
                indexname = 'ggircs_facility_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id
    $$ select 'ghgr_import_id' $$,

    'All columns in unique index ggircs_facility_primary_key are used in join when creating ggircs.activity -> ggircs.lfo_facility FK relation'
);

-- Additional Data -> Report
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

    'All columns in unique index ggircs_report_primary_key are used in join when creating ggircs.additional_activity -> ggircs.report FK relation'
);

-- Additional Data -> Activity
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
                tablename = 'activity'
            and
                indexname = 'ggircs_activity_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id, process_idx, sub_process_idx, activity_name
    $$ select 'ghgr_import_id, process_idx, sub_process_idx, activity_name' $$,

    'All columns in unique index ggircs_activity_primary_key are used in join when creating ggircs.additional_data -> ggircs.activity FK relation'
);

-- Address -> Report
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

    'All columns in unique index ggircs_report_primary_key are used in join when creating ggircs.additional_data -> ggircs.report FK relation'
);

-- Address -> Single Facility
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
                tablename = 'facility'
            and
                indexname = 'ggircs_facility_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id
    $$ select 'ghgr_import_id' $$,

    'All columns in unique index ggircs_facility_primary_key are used in join when creating ggircs.address -> ggircs.single_facility FK relation'
);

-- Address -> LFO Facility
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
                tablename = 'facility'
            and
                indexname = 'ggircs_facility_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id
    $$ select 'ghgr_import_id' $$,

    'All columns in unique index ggircs_facility_primary_key are used in join when creating ggircs.address -> ggircs.lfo_facility FK relation'
);

-- Address -> Organisation
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
                tablename = 'organisation'
            and
                indexname = 'ggircs_organisation_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id
    $$ select 'ghgr_import_id' $$,

    'All columns in unique index ggircs_organisation_primary_key are used in join when creating ggircs.address -> ggircs.organisation FK relation'
);

-- Address -> Parent Organisation
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
                tablename = 'parent_organisation'
            and
                indexname = 'ggircs_parent_organisation_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id, path_context, parent_organisation_idx
    $$ select 'ghgr_import_id, path_context, parent_organisation_idx' $$,

    'All columns in unique index ggircs_parent_organisation_primary_key are used in join when creating ggircs.address -> ggircs.parent_organisation FK relation'
);

/** FACILITY **/

-- Single Facility -> Organisation
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
                tablename = 'organisation'
            and
                indexname = 'ggircs_organisation_primary_key')
        from '(?<=\().+?(?=\))')
    $$,

    -- columns used in join: ghgr_import_id
    $$ select 'ghgr_import_id' $$,

    'All columns in unique index ggircs_organisation_primary_key are used in join when creating ggircs.single_facility -> ggircs.organisation FK relation'
);

-- Single Facility -> Report
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

    'All columns in unique index ggircs_report_primary_key are used in join when creating ggircs.single_facility -> ggircs.report FK relation'
);

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

    'All columns in unique index ggircs_report_primary_key are used in join when creating ggircs.fuel -> ggircs.report FK relation'
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

    'All columns in unique index ggircs_unit_primary_key are used in join when creating ggircs.fuel -> ggircs.unit FK relation'
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

    'All columns in unique index ggircs_fuel_mapping_fuel_type are used in join when creating ggircs.fuel -> ggircs.fuel_mapping FK relation'
);

/** ORGANISATION **/
-- Organisation -> Report
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

    'All columns in unique index ggircs_report_primary_key are used in join when creating ggircs.organisation -> ggircs.report FK relation'
);

select * from finish();
rollback;
