-- @connect sysdba
-- what ATLAS needs for row-level security: DBMS_RLS, and an application context
grant execute on dbms_rls to atlas;
create or replace context atlas_ctx using atlas.atlas_security;
