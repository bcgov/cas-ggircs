-- Deploy ggircs-app:mutations/create_ggircs_user_from_session to pg

begin;


create or replace function ggircs_app.create_ggircs_user_from_session()
returns ggircs_app.ggircs_user
as $function$
declare
  jwt ggircs_app.jwt_token;
  result ggircs_app.ggircs_user;
begin
  select * from ggircs_app.session() into jwt;

  if (select count(*) from ggircs_app.ggircs_user where session_sub=jwt.sub) = 0
  then

    insert into ggircs_app.ggircs_user(session_sub, first_name, last_name, email_address, allow_sub_update)
    values (jwt.sub, jwt.given_name, jwt.family_name, jwt.email, false)
    on conflict(email_address) do
    update
    set session_sub=excluded.session_sub,
        given_name=excluded.first_name,
        family_name=excluded.last_name,
        allow_sub_update=false;

  end if;

  select * from ggircs_app.ggircs_user where session_sub = jwt.sub into result;
  return result;
end;
$function$ language plpgsql strict volatile security definer;

grant execute on function ggircs_app.create_ggircs_user_from_session to ggircs_user;

comment on function ggircs_app.create_ggircs_user_from_session is 'Function creates a user if a user with the matching session_sub does not exist, otherwise returns the matching user';

commit;
