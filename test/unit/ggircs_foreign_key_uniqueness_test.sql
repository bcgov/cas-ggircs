set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

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

    $$ select 'ghgr_import_id, activity_name, process_idx, sub_process_idx, units_idx, unit_idx' $$,

    'All columns in index ggircs_unit_primary_key are used in join when creating ggircs.fuel -> ggircs.unit FK relation'
);

select * from finish();
rollback;
