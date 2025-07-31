-- Revert ggircs-app:types/jwt_token from pg

begin;

-- Drop dependent policies BEFORE altering the type
drop policy if exists ggircs_user_insert_ggircs_user on ggircs_app.ggircs_user;
drop policy if exists ggircs_user_update_ggircs_user on ggircs_app.ggircs_user;

-- Now revert the type change
alter type ggircs_app.jwt_token alter attribute sub type uuid;

do $$
declare
  colname text;
  comment_sql text;
begin
  select column_name into colname
    from information_schema.columns
    where table_schema = 'ggircs_app'
      and table_name = 'ggircs_user'
      and column_name in ('session_sub', 'uuid')
    order by case column_name when 'session_sub' then 1 when 'uuid' then 2 end
    limit 1;

  comment_sql := format(
    'comment on type ggircs_app.jwt_token is E''@primaryKey sub\n@foreignKey (sub) references ggircs_user (%I)'';',
    colname
  );
  execute comment_sql;
end
$$;

commit;
