-- Deploy ggircs:swrs/parameters/table/gwp to pg

begin;

create table ggircs_parameters.gwp (
  id integer generated always as identity primary key,
  gas_type varchar(1000),
  gwp int
);

comment on table ggircs_parameters.gwp is 'The gwp table contains AR5 (Intergovernmental Panel onClimate Change’s (IPCC) Fifth Assessment Report) GWP values global warming potential values';
comment on column ggircs_parameters.gwp.id is 'The internal primary key';
comment on column ggircs_parameters.gwp.gas_type is 'The gas type';
comment on column ggircs_parameters.gwp.gwp is 'The global warming potential pertaining to a specific gas type';

insert into ggircs_parameters.gwp (gas_type, gwp) values
('CO2',1),
('CO2bioC',1),
('CO2bio-C',1),
('CO2bionC',1),
('CO2bioNC',1),
('CO2nonbio',1),
('CH4',28),
('N2O',265),
('HFC23_CHF3',12400),
('HFC32_CH2F2',677),
('HFC41_CH3F',116),
('HFC4310mee_C5H2F10',1650),
('HFC125_C2HF5',3170),
('HFC134_C2H2F4',1120),
('HFC134a_C2H2F4',1300),
('HFC143_C2H3F3',328),
('HFC143_CHF2CH2F',328),
('HFC143a_C2H3F3',4800),
('HFC143a_CF3CH3',4800),
('HFC152a_C2H4F2',138),
('HFC152a_CH3CHF2',138),
('HFC227ea_C3HF7',3350),
('HFC236fa_C3H2F6',8060),
('HFC245ca_C3H3F5',716),
('Perfluoromethane_CF4',6630),
('Perfluoroethane_C2F6',11100),
('Perfluoropropane_C3F8',8900),
('Perfluorobutane_C4F10',9200),
('Perfluorocyclobutane_cC4F8',9540),
('Perfluoropentane_C5F12',8550),
('Perfluorohexane_C6F14',7910),
('SF6',23500);

commit;
