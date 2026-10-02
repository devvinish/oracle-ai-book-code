-- Installs the Atlas Support sample schema. Run as ATLAS in SQL*Plus or SQLcl:
--   sql atlas@localhost:1521/FREEPDB1 @install.sql
set echo off feedback off
@@schema.sql
@@data.sql
set feedback on
select 'Atlas Support installed: ' || (select count(*) from tickets) || ' tickets, '
       || (select count(*) from kb_articles) || ' knowledge base articles' as result
from dual;
