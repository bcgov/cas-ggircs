-- Deploy ggircs:ignore_organisation to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs_transform.ignore_organisation (
  swrs_organisation_id integer not null primary key
);

insert into swrs_transform.ignore_organisation (swrs_organisation_id)
values   (5367)
       , (5401)
       , (6432)
       , (29004)
       , (29110)
       , (40627)
       , (42118)
       , (42261)
       , (42288)
       , (50606)
       , (54742)
       , (100251)
       , (100306)
        ,(100354)
        ,(111380)
        ,(111404)
        ,(111427)
        ,(111519)
       , (111616)
       , (111617)
       , (111619)
       , (111620)
       , (111636)
       , (111911)
       , (112001)
       , (112114)
       , (112126)
       , (112130)
        ,(112158)
        ,(112202)
        ,(112205)
        ,(112214)
        ,(112226)
        ,(112262)
        ,(112270)
       , (112291)
       , (112466)
       , (112543)
        ,(112560)
        ,(112594)
       , (112649)
        ,(112659)
        ,(112660)
        ,(112661)
        ,(112685)
       , (112706)
       , (113002)
       , (113072)
       , (113119)
       , (113121)


on conflict (swrs_organisation_id) do nothing;

comment on table swrs_transform.ignore_organisation is 'The list of organisations from the federal single window reporting system to ignore';
comment on column swrs_transform.ignore_organisation.swrs_organisation_id is 'The foreign key from swrs of the organisation that should be ignored';

commit;
