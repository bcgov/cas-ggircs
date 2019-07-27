-- Deploy ggircs:ciip_table_operator to pg
-- requires: ciip_table_application

begin;

create table ciip_2018.operator
(
    id                          serial primary key,
    application_id              integer references ciip_2018.application(id),
    swrs_operator_id            integer,
    business_legal_name         varchar(1000),
    english_trade_name          varchar(1000),
    bc_corp_reg_number          varchar(1000),
    is_bc_cop_reg_number_valid  boolean,
    orgbook_legal_name          varchar(1000),
    is_registration_active      boolean,
    duns                        varchar(1000)
);

create index ciip_operator_application_foreign_key on ciip_2018.operator(application_id);

comment on table ciip_2018.operator is 'the table housing all report data pertaining to the reporting organisation';
comment on column ciip_2018.operator.id is 'The primary key';
comment on column ciip_2018.operator.application_id is 'A foreign key reference to ccip.application';
comment on column ciip_2018.operator.swrs_operator_id           is 'The id of the operator in SWRS';
comment on column ciip_2018.operator.business_legal_name        is 'The business legal name';
comment on column ciip_2018.operator.english_trade_name         is 'The trade name of the operator';
comment on column ciip_2018.operator.bc_corp_reg_number         is 'The BC corporation registry number';
comment on column ciip_2018.operator.is_bc_cop_reg_number_valid is 'Whether the BC corporation registry number appears in OrgBook';
comment on column ciip_2018.operator.orgbook_legal_name         is 'The legal name of the operator according to OrgBook';
comment on column ciip_2018.operator.is_registration_active     is 'Whether the registration is marked as active in OrgBook';
comment on column ciip_2018.operator.duns                       is 'The operator DUNS';

commit;

