-- Revert ggircs-app:triggers/user_session_sub_immutable_with_flag from pg

begin;

drop function ggircs_app_private.user_session_sub_immutable_with_flag_set;

commit;
