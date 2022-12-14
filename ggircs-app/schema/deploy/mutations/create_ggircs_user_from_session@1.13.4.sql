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

  if ((select count(*) from ggircs_app.ggircs_user where uuid = jwt.sub) = 0) then
    insert into ggircs_app.ggircs_user(uuid, first_name, last_name, email_address)
    values (jwt.sub, jwt.given_name, jwt.family_name, jwt.email);
  end if;


  select * from ggircs_app.ggircs_user where uuid = jwt.sub into result;
  return result;
end;
$function$ language plpgsql strict volatile;

grant execute on function ggircs_app.create_ggircs_user_from_session to ggircs_user;

commit;
