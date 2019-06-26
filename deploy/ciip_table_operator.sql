-- Deploy ggircs:ciip_table_operator to pg
-- requires: ciip_table_application

begin;

create table ciip.operator
(
    id                          serial primary key,
    application_id              integer references ciip.application(id),
    swrs_operator_id            integer,
    business_legal_name         varchar(1000),
    english_trade_name          varchar(1000),
    bc_corp_reg_number          varchar(1000),
    is_bc_cop_reg_number_valid  boolean,
    orgbook_legal_name          varchar(1000),
    is_registration_active      boolean,
    duns                        varchar(1000)
);

create index ciif_operator_application_foreign_key on ciip.operator(application_id);

comment on table ciip.operator is 'the table housing all report data pertaining to the reporting organisation';
comment on column ciip.operator.id is 'The primary key';
comment on column ciip.operator.application_id is 'A foreign key reference to ccip.application';

commit;

