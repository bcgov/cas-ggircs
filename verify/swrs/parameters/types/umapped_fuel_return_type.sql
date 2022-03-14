-- Verify ggircs:swrs/parameters/types/umapped_fuel_return_type on pg

begin;

do $$
  begin
    assert (
      select true from pg_catalog.pg_type where typname = 'unmapped_fuel_return'
    ), 'type "unmapped_fuel_return" is not defined';
  end;
$$;

rollback;
