-- Verify ggircs-app:types/jwt_token on pg

begin;

do $$
  begin
    assert (
      select true from pg_catalog.pg_type where typname = 'jwt_token'
    ), 'type "jwt_token" is not defined';
  end;
$$;

rollback;
