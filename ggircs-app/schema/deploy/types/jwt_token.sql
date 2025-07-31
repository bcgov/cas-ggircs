-- Deploy ggircs-app:types/jwt_token to pg


begin;

-- Disabling the trigger to allow this migration to make changes to the data in the table
-- while keeping the audit values in updated_at/by unchanged
alter table ggircs_app.ggircs_user disable trigger _100_timestamps;

-- Dropping existing policies that depend on the uuid
drop policy if exists ggircs_user_insert_ggircs_user on ggircs_app.ggircs_user;
drop policy if exists ggircs_user_update_ggircs_user on ggircs_app.ggircs_user;

alter type ggircs_app.jwt_token alter attribute sub type text;

comment on type ggircs_app.jwt_token is E'@primaryKey sub\n@foreignKey (sub) references ggircs_user (session_sub)';

-- Rebuilding policies with the proper session_sub reference
do
$policy$
declare
  colname text;
begin
  select column_name into colname
    from information_schema.columns
    where table_schema = 'ggircs_app'
      and table_name = 'ggircs_user'
      and column_name in ('session_sub', 'uuid')
    order by case column_name when 'session_sub' then 1 when 'uuid' then 2 end
    limit 1;

  execute format(
    'select ggircs_app_private.upsert_policy(''ggircs_user_insert_ggircs_user'', ''ggircs_user'', ''insert'', ''ggircs_user'', ''%I=(select sub::text from ggircs_app.session())'')',
    colname
  );
  execute format(
    'select ggircs_app_private.upsert_policy(''ggircs_user_update_ggircs_user'', ''ggircs_user'', ''update'', ''ggircs_user'', ''%I=(select sub::text from ggircs_app.session())'')',
    colname
  );
end
$policy$;

-- Re-enabling the trigger after we update the data
alter table ggircs_app.ggircs_user enable trigger _100_timestamps;

commit;
