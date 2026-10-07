-- Made by tools/publish/make_app200_setup.py of the book from the examples; do not edit.
-- Prepares the database of the lab of Chapter 2 for Atlas Support (application 200): what the
-- book does as a DBA in Chapters 2, 5, 13 and 27. Run as SYS in the pluggable database (SYSTEM
-- may not grant EXECUTE on SYS.DBMS_VECTOR), from this folder, with the password of ATLAS (used
-- only if ATLAS doesn't exist yet):
--   sql sys@localhost:1521/FREEPDB1 as sysdba @dba.sql 'Your_Atlas_Password1'
-- What is already there is left as it is, so the script is safe to run again.
whenever sqlerror exit failure
set define on verify off feedback off serveroutput on

prompt 1/5 The user ATLAS (Chapter 2)...
declare
  l_count number;
begin
  select count(*) into l_count from dba_users where username = 'ATLAS';
  if l_count = 0 then
    execute immediate 'create user atlas identified by "&1" default tablespace users quota unlimited on users';
    dbms_output.put_line('    User ATLAS created.');
  else
    dbms_output.put_line('    User ATLAS exists; its password is unchanged.');
  end if;
end;
/
grant db_developer_role to atlas;
grant create mining model to atlas;
grant execute on sys.dbms_vector to atlas;
grant execute on ctxsys.dbms_vector_chain to atlas;
grant execute on ctxsys.dbms_hybrid_vector to atlas;
grant execute on sys.dbms_data_mining to atlas;
grant ctxapp to atlas;
grant create credential to atlas;
grant execute on sys.utl_http to atlas;

prompt 2/5 Network access to Gemini, for ATLAS and for APEX (Chapter 2)...
declare
  l_count number;
begin
  for p in (select 'ATLAS' as principal from dual
            union all
            select schema from dba_registry where comp_id = 'APEX') loop
    select count(*) into l_count from dba_host_aces
    where  host = 'generativelanguage.googleapis.com' and principal = p.principal
    and    privilege = 'HTTP';
    if l_count = 0 then
      dbms_network_acl_admin.append_host_ace(
        host => 'generativelanguage.googleapis.com',
        ace  => xs$ace_type(privilege_list => xs$name_list('http'),
                            principal_name => p.principal,
                            principal_type => xs_acl.ptype_db));
    end if;
  end loop;
end;
/

prompt 3/5 The folder ATLAS_FILES, for the model and the documents (Chapters 5 and 9)...
create or replace directory atlas_files as '/opt/oracle/atlas_files';
grant read, write on directory atlas_files to atlas;

prompt 4/5 Row-level security for the documents (Chapter 27)...
grant execute on dbms_rls to atlas;
create or replace context atlas_ctx using atlas.atlas_security;

prompt 5/5 ATLAS_READER, which runs the queries of Ask Your Data (Chapter 13)...
create user if not exists atlas_reader no authentication;
begin
  for t in (select column_value as table_name
            from   sys.odcivarchar2list('PRODUCTS', 'CUSTOMERS', 'AGENTS', 'TICKETS', 'TICKET_COMMENTS', 'KB_ARTICLES')) loop
    execute immediate 'create or replace synonym atlas_reader.' || t.table_name
                      || ' for atlas.' || t.table_name;
  end loop;
end;
/
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

prompt Done. Now run install.sql as ATLAS.
whenever sqlerror continue
