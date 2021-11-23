-- Deploy ggircs:swrs/transform/function/load_taxed_venting_emission_type to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/taxed_venting_emission_type

begin;

create or replace function swrs_transform.load_taxed_venting_emission_type()
  returns void as
$function$
  begin

    delete from swrs_load.taxed_venting_emission_type;

    insert into swrs_load.taxed_venting_emission_type(
      id,
      taxed_venting_emission_type
    )
    values(
    (1, 'NG Distribution: NG continuous high bleed devices venting'),
    (2, 'NG Distribution: NG continuous low bleed devices venting'),
    (3, 'NG Distribution: NG intermittent devices venting'),
    (4, 'NG Distribution: NG pneumatic pumps venting'),
    (5, 'Onshore NG Transmission Compression/Pipelines: NG continuous high bleed devices venting'),
    (6, 'Onshore NG Transmission Compression/Pipelines: NG continuous low bleed devices venting'),
    (7, 'Onshore NG Transmission Compression/Pipelines: NG intermittent devices venting'),
    (8, 'Onshore NG Transmission Compression/Pipelines: NG pneumatic pumps venting'),
    (9, 'Onshore Petroleum and NG Production: NG continuous high bleed devices venting'),
    (10, 'Onshore Petroleum and NG Production: NG continuous low bleed devices venting'),
    (11, 'Onshore Petroleum and NG Production: NG intermittent devices venting'),
    (12, 'Onshore Petroleum and NG Production: NG pneumatic pump venting'),
    (13, 'Underground NG Storage: NG continuous high bleed devices venting'),
    (14, 'Underground NG Storage: NG continuous low bleed devices venting'),
    (15, 'Underground NG Storage: NG intermittent devices venting'),
    (16, 'Underground NG Storage: NG pneumatic pumps venting')
    );

  end;
$function$ language plpgsql volatile;

commit;

