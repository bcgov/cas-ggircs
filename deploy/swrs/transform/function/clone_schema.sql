-- Deploy ggircs:swrs/transform/function/clone_schema to pg
-- requires: swrs/transform/schema

BEGIN;

-- Function: clone_schema(source text, dest text, include_records boolean default true, show_details boolean default false)

-- DROP FUNCTION clone_schema(text, text, boolean, boolean);

CREATE OR REPLACE FUNCTION swrs_transform.clone_schema(
  source_schema text,
  dest_schema text,
  include_recs boolean DEFAULT true,
  show_details boolean DEFAULT false)
  RETURNS void AS
$BODY$

--  This function will clone all sequences, tables, data, views & functions from any existing schema to a new one
-- SAMPLE CALL:
-- SELECT clone_schema('public', 'new_schema');
-- SELECT clone_schema('public', 'new_schema', TRUE);
-- SELECT clone_schema('public', 'new_schema', TRUE, TRUE);

DECLARE
  src_oid          oid;
  tbl_oid          oid;
  func_oid         oid;
  object           text;
  buffer           text;
  srctbl           text;
  default_         text;
  column_          text;
  qry              text;
  xrec             record;
  dest_qry         text;
  v_def            text;
  seqval           bigint;
  sq_last_value    bigint;
  sq_max_value     bigint;
  sq_start_value   bigint;
  sq_increment_by  bigint;
  sq_min_value     bigint;
  sq_cache_value   bigint;
  sq_log_cnt       bigint;
  sq_is_called     boolean;
  sq_cycle_option  char(10);
  rec              record;
  source_schema_dot text = source_schema || '.';
  dest_schema_dot text = dest_schema || '.';
  cycle_clause text;

BEGIN

  -- Check that source_schema exists
  SELECT oid INTO src_oid
  FROM pg_namespace
  WHERE nspname = quote_ident(source_schema);
  IF NOT FOUND
  THEN
    RAISE NOTICE 'source schema % does not exist!', source_schema;
    RETURN ;
  END IF;

  -- Check that dest_schema does not yet exist
  PERFORM nspname
  FROM pg_namespace
  WHERE nspname = quote_ident(dest_schema);
  IF FOUND
  THEN
    RAISE NOTICE 'dest schema % already exists!', dest_schema;
    RETURN ;
  END IF;

  EXECUTE 'CREATE SCHEMA ' || quote_ident(dest_schema) ;

  -- Create sequences
  -- TODO: Find a way to make this sequence's owner is the correct table.
  FOR object IN
  SELECT sequence_name::text
  FROM information_schema.sequences
  WHERE sequence_schema = quote_ident(source_schema)
  LOOP

    cycle_clause := CASE sq_cycle_option
                      WHEN 'YES' THEN ' CYCLE'
                      ELSE ' NO CYCLE'
                    END;

    EXECUTE 'CREATE SEQUENCE ' || quote_ident(dest_schema) || '.' || quote_ident(object);
    srctbl := quote_ident(source_schema) || '.' || quote_ident(object);

    EXECUTE 'SELECT maximum_value, start_value, increment, minimum_value, cycle_option
              FROM information_schema.sequences where sequence_schema=''' || quote_ident(source_schema) || ''' and sequence_name=''' || quote_ident(object) || ''';'
    INTO sq_max_value, sq_start_value, sq_increment_by, sq_min_value, sq_cycle_option ;

    EXECUTE 'select last_value, log_cnt, is_called from ' || srctbl || ';'
    INTO sq_last_value, sq_log_cnt, sq_is_called;

    EXECUTE 'ALTER SEQUENCE '   || quote_ident(dest_schema) || '.' || quote_ident(object)
            || ' INCREMENT BY ' || sq_increment_by
            || ' MINVALUE '     || sq_min_value
            || ' MAXVALUE '     || sq_max_value
            || ' START WITH '   || sq_start_value
            || ' RESTART WITH ' || sq_min_value
            || cycle_clause     || ' ;' ;

    buffer := quote_ident(dest_schema) || '.' || quote_ident(object);
    IF include_recs
    THEN
      EXECUTE 'SELECT setval( ''' || buffer || ''', ' || sq_last_value || ', ' || sq_is_called || ');' ;
    ELSE
      EXECUTE 'SELECT setval( ''' || buffer || ''', ' || sq_start_value || ', ' || sq_is_called || ');' ;
    END IF;
    IF show_details THEN RAISE NOTICE 'Sequence created: %', object; END IF;
  END LOOP;

  -- Create tables
  FOR object IN
  SELECT TABLE_NAME::text
  FROM information_schema.tables
  WHERE table_schema = quote_ident(source_schema)
        AND table_type = 'BASE TABLE'

  LOOP
    buffer := dest_schema || '.' || quote_ident(object);
    EXECUTE 'CREATE TABLE ' || buffer || ' (LIKE ' || quote_ident(source_schema) || '.' || quote_ident(object)
            || ' INCLUDING ALL)';

    IF include_recs
    THEN
      -- Insert records from source table
      EXECUTE 'INSERT INTO ' || buffer || ' OVERRIDING SYSTEM VALUE SELECT * FROM ' || quote_ident(source_schema) || '.' || quote_ident(object) || ';';
    END IF;

    FOR column_, default_ IN
    SELECT column_name::text,
      REPLACE(column_default::text, source_schema, dest_schema)
    FROM information_schema.COLUMNS
    WHERE table_schema = dest_schema
          AND TABLE_NAME = object
          AND column_default LIKE 'nextval(%' || quote_ident(source_schema) || '%::regclass)'
    LOOP
      EXECUTE 'ALTER TABLE ' || buffer || ' ALTER COLUMN ' || column_ || ' SET DEFAULT ' || default_;
    END LOOP;

    IF show_details THEN RAISE NOTICE 'base table created: %', object; END IF;

  END LOOP;

  --  add FK constraint
  FOR xrec IN
  SELECT ct.conname as fk_name, rn.relname as tb_name,  'ALTER TABLE ' || quote_ident(dest_schema) || '.' || quote_ident(rn.relname)
         || ' ADD CONSTRAINT ' || quote_ident(ct.conname) || ' ' || replace(pg_get_constraintdef(ct.oid), source_schema_dot, dest_schema_dot) || ';' as qry
  FROM pg_constraint ct
    JOIN pg_class rn ON rn.oid = ct.conrelid
  WHERE connamespace = src_oid
        AND rn.relkind = 'r'
        AND ct.contype = 'f'

  LOOP
    IF show_details THEN RAISE NOTICE 'Creating FK constraint %.%...', xrec.tb_name, xrec.fk_name; END IF;
    --RAISE NOTICE 'DEF: %', xrec.qry;
    EXECUTE xrec.qry;
  END LOOP;

  -- Create functions
  FOR xrec IN
  SELECT proname as func_name, oid as func_oid
  FROM pg_proc
  WHERE pronamespace = src_oid

  LOOP
    IF show_details THEN RAISE NOTICE 'Creating function %...', xrec.func_name; END IF;
    SELECT pg_get_functiondef(xrec.func_oid) INTO qry;
    -- Split the function by the 'AS' part in order to only replace the source_schema in the definition, paramters and return values.
    SELECT replace((select split_part(qry, 'AS', 1)), source_schema_dot, dest_schema_dot) INTO dest_qry;
    -- Rebuild the function by concatenating the replaced definition with the unchanged body
    EXECUTE dest_qry || 'AS' || (SELECT split_part(qry, 'AS', 2));
  END LOOP;

  -- add Table Triggers
  FOR rec IN
  SELECT
    trg.tgname AS trigger_name,
    tbl.relname AS trigger_table,

    CASE
    WHEN trg.tgenabled='O' THEN 'ENABLED'
    ELSE 'DISABLED'
    END AS status,
    CASE trg.tgtype::integer & 1
    WHEN 1 THEN 'ROW'::text
    ELSE 'STATEMENT'::text
    END AS trigger_level,
    CASE trg.tgtype::integer & 66
    WHEN 2 THEN 'BEFORE'
    WHEN 64 THEN 'INSTEAD OF'
    ELSE 'AFTER'
    END AS action_timing,
    CASE trg.tgtype::integer & cast(60 AS int2)
    WHEN 16 THEN 'UPDATE'
    WHEN 8 THEN 'DELETE'
    WHEN 4 THEN 'INSERT'
    WHEN 20 THEN 'INSERT OR UPDATE'
    WHEN 28 THEN 'INSERT OR UPDATE OR DELETE'
    WHEN 24 THEN 'UPDATE OR DELETE'
    WHEN 12 THEN 'INSERT OR DELETE'
    WHEN 32 THEN 'TRUNCATE'
    END AS trigger_event,
    'EXECUTE PROCEDURE ' ||  (SELECT nspname FROM pg_namespace where oid = pc.pronamespace )
    || '.' || proname || '('
    || regexp_replace(replace(trim(trailing '\000' from encode(tgargs,'escape')), '\000',','),'{(.+)}','''{\1}''','g')
    || ')' as action_statement

  FROM pg_trigger trg
    JOIN pg_class tbl on trg.tgrelid = tbl.oid
    JOIN pg_proc pc ON pc.oid = trg.tgfoid
  WHERE trg.tgname not like 'RI_ConstraintTrigger%'
        AND trg.tgname not like 'pg_sync_pg%'
        AND tbl.relnamespace = (SELECT oid FROM pg_namespace where nspname = quote_ident(source_schema) )

  LOOP
    buffer := dest_schema || '.' || quote_ident(rec.trigger_table);
    IF show_details THEN RAISE NOTICE 'Creating trigger % % % ON %...', rec.trigger_name, rec.action_timing, rec.trigger_event, rec.trigger_table; END IF;
    EXECUTE 'CREATE TRIGGER ' || rec.trigger_name || ' ' || rec.action_timing
            || ' ' || rec.trigger_event || ' ON ' || buffer || ' FOR EACH '
            || rec.trigger_level || ' ' || replace(rec.action_statement, source_schema_dot, dest_schema_dot);

  END LOOP;

  -- Create views on order of dependency
  FOR object IN
    with deps as (
        select dependent_view.relname as dep_view_name, source_table.relname as src_view_name
        from pg_depend
        join pg_rewrite on pg_depend.objid = pg_rewrite.oid
        join pg_class as dependent_view on pg_rewrite.ev_class = dependent_view.oid
        join pg_class as source_table on pg_depend.refobjid = source_table.oid
        join pg_attribute on pg_depend.refobjid = pg_attribute.attrelid
        and pg_depend.refobjsubid = pg_attribute.attnum
        join pg_namespace dependent_ns on dependent_ns.oid = dependent_view.relnamespace
        join pg_namespace source_ns on source_ns.oid = source_table.relnamespace
        join information_schema.views source_views on source_views.table_name = source_table.relname
        and source_views.table_schema = quote_ident(source_schema)
        where source_ns.nspname = quote_ident(source_schema)
        and dependent_ns.nspname = quote_ident(source_schema)
        group by dependent_view.relname, source_table.relname)
select views.table_name::text, views.view_definition
    from information_schema.views
    left join deps on views.table_name = deps.dep_view_name
    where views.table_schema = quote_ident(source_schema)
    order by deps.src_view_name nulls first

  LOOP
    buffer := dest_schema || '.' || quote_ident(object);
    SELECT replace(view_definition, source_schema_dot, dest_schema_dot) INTO v_def
    FROM information_schema.views
    WHERE table_schema = quote_ident(source_schema)
          AND table_name = quote_ident(object);
    IF show_details THEN RAISE NOTICE 'Creating view % AS %', object, regexp_replace(v_def, '[\n\r]+', ' ', 'g'); END IF;
    EXECUTE 'CREATE OR REPLACE VIEW ' || buffer || ' AS ' || v_def || ';' ;

  END LOOP;

  RETURN;

END;

$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

COMMIT;
