-- @connect sysdba
create or replace directory atlas_files as '/opt/oracle/atlas_files';
grant read, write on directory atlas_files to atlas;
