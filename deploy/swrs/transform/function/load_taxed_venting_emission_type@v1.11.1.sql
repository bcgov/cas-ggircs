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
      taxed_emission_type
    )
    values
      ('NG Distribution: NG continuous high bleed devices venting'),
      ('NG Distribution: NG continuous low bleed devices venting'),
      ('NG Distribution: NG intermittent devices venting'),
      ('NG Distribution: NG pneumatic pumps venting'),
      ('Onshore NG Transmission Compression/Pipelines: NG continuous high bleed devices venting'),
      ('Onshore NG Transmission Compression/Pipelines: NG continuous low bleed devices venting'),
      ('Onshore NG Transmission Compression/Pipelines: NG intermittent devices venting'),
      ('Onshore NG Transmission Compression/Pipelines: NG pneumatic pumps venting'),
      ('Onshore Petroleum and NG Production: NG continuous high bleed devices venting'),
      ('Onshore Petroleum and NG Production: NG continuous low bleed devices venting'),
      ('Onshore Petroleum and NG Production: NG intermittent devices venting'),
      ('Onshore Petroleum and NG Production: NG pneumatic pump venting'),
      ('Underground NG Storage: NG continuous high bleed devices venting'),
      ('Underground NG Storage: NG continuous low bleed devices venting'),
      ('Underground NG Storage: NG intermittent devices venting'),
      ('Underground NG Storage: NG pneumatic pumps venting');

  end;
$function$ language plpgsql volatile;

commit;
