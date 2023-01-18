-- Verify ggircs-app:triggers/user_session_sub_immutable_with_flag on pg

begin;

select pg_get_functiondef('ggircs_app_private.user_session_sub_immutable_with_flag_set()'::regprocedure);

rollback;
