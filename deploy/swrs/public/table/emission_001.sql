-- Deploy ggircs:swrs/public/table/emission_001 to pg
-- requires: swrs/public/table/emission

begin;

alter table swrs.emission add column cas_number varchar(1000);

comment on column swrs.emission.cas_number is 'Refers to the Chemical Abstracts Service Registry Number. It is a unique number code used in chemistry';

commit;
