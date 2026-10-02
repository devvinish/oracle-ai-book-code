-- The SQLcl settings that every example of the book ran with (Chapter 3).
-- SQLcl runs login.sql automatically after every connection when it finds the file in the
-- current folder or in a folder of SQLPATH.
set sqlformat ansiconsole
set pagesize 500 serveroutput on size unlimited
set sqlblanklines on define off verify off tab off
set long 100000 longchunksize 100000
alter session set nls_date_format = 'DD-MON-YYYY';
alter session set nls_timestamp_format = 'DD-MON-YYYY HH24:MI:SS';
alter session set nls_timestamp_tz_format = 'DD-MON-YYYY HH24:MI:SS TZR';
alter session set time_zone = 'UTC';
