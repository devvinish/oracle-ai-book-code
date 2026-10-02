-- the space the two embedding columns of TICKETS take, in the table and in LOB segments
select c.column_name,
       round(sum(s.bytes) / 1024 / 1024, 1) as mb
from   user_lobs c
join   user_segments s on s.segment_name in (c.segment_name, c.index_name)
where  c.table_name = 'TICKETS'
and    c.column_name in ('EMBEDDING', 'GEMINI_EMBEDDING')
group  by c.column_name
union all
select 'TICKETS (the table)', round(bytes / 1024 / 1024, 1)
from   user_segments
where  segment_name = 'TICKETS';
