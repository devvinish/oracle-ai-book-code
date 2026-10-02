-- @connect sysdba
select pool, round(alloc_bytes / 1024 / 1024) as allocated_mb,
       round(used_bytes / 1024 / 1024) as used_mb
from   v$vector_memory_pool
where  con_id = sys_context('USERENV', 'CON_ID');
