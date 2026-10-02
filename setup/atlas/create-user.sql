-- Creates the ATLAS schema of the book. Run as a DBA in the PDB (FREEPDB1):
--   sqlplus system@localhost:1521/FREEPDB1 @create-user.sql <password>
-- The password is the first argument; choose your own.
create user atlas identified by "&1"
  default tablespace users quota unlimited on users;

-- tables, views, procedures, sequences, types, triggers, ... (Oracle's role for developers)
grant db_developer_role to atlas;

-- AI Vector Search and in-database machine learning
grant create mining model to atlas;
grant execute on sys.dbms_vector to atlas;
grant execute on ctxsys.dbms_vector_chain to atlas;    -- owned by Oracle Text (CTXSYS)
grant execute on ctxsys.dbms_hybrid_vector to atlas;
grant execute on sys.dbms_data_mining to atlas;
grant ctxapp to atlas;                                  -- Oracle Text: documents to text, chunking
grant create credential to atlas;                       -- keys of AI providers, stored in the database

-- calling AI providers over HTTPS (the host list is in the ACL below)
grant execute on sys.utl_http to atlas;

begin
  dbms_network_acl_admin.append_host_ace(
    host => 'generativelanguage.googleapis.com',
    ace  => xs$ace_type(privilege_list => xs$name_list('http'),
                        principal_name => 'ATLAS',
                        principal_type => xs_acl.ptype_db));
end;
/
