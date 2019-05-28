-- Deploy ggircs:function_refresh_materialized_views to pg
-- requires: table_ghgr_import

begin;

-- @view: string (the view to refresh), @data string (with or without data)
create or replace function ggircs_swrs.refresh_materialized_views(view text, data text)
  returns void as
$$

begin
  -- Refresh views with data
    execute format('refresh materialized view ggircs_swrs.%s %s', view, data);
end

$$ language plpgsql volatile ;

commit;
