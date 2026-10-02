-- ATLAS lets the reader query the six tables, and nothing else
begin
  for t in (select table_name from nl2sql_tables) loop
    execute immediate 'grant select on ' || t.table_name || ' to atlas_reader';
  end loop;
end;
/

select table_name, privilege from user_tab_privs_made where grantee = 'ATLAS_READER'
order  by table_name;
