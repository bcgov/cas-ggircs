begin;

truncate swrs.report restart identity cascade;
truncate swrs.fuel restart identity cascade;
delete from ggircs_parameters.fuel_mapping where fuel_type='Not Mapped';

commit;
