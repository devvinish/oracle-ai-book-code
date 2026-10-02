-- @connect sysdba
-- synonyms, so that queries can name the tables without the schema
begin
  for t in (select table_name from atlas.nl2sql_tables) loop
    execute immediate 'create or replace synonym atlas_reader.' || t.table_name
                      || ' for atlas.' || t.table_name;
  end loop;
end;
/

-- runs a query with the privileges of ATLAS_READER, and returns at most 50 rows as JSON
create or replace function atlas_reader.query_json (p_sql in clob) return clob
authid definer
is
  l_rows clob;
begin
  execute immediate
    'select json_arrayagg(json_object(*) returning clob) from (select * from ('
    || p_sql || ') fetch first 50 rows only)'
    into l_rows;
  return l_rows;
end;
/

grant execute on atlas_reader.query_json to atlas;
