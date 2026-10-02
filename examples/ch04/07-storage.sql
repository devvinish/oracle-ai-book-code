-- @setup drop table if exists size_f32 purge
-- @setup drop table if exists size_int8 purge
-- @setup drop table if exists size_binary purge
-- @cleanup drop table if exists size_f32 purge
-- @cleanup drop table if exists size_int8 purge
-- @cleanup drop table if exists size_binary purge
create table size_f32    (id number, v vector(384, float32));
create table size_int8   (id number, v vector(384, int8));
create table size_binary (id number, v vector(384, binary));

-- 2,000 random vectors of 384 dimensions in each table
insert into size_f32
select level, (select to_vector('[' || listagg(round(dbms_random.value(-1, 1), 4), ',')
                                       within group (order by null) || ']')
               from dual connect by level <= 384)
from   dual connect by level <= 2000;

insert into size_int8
select level, (select to_vector('[' || listagg(round(dbms_random.value(-127, 127)), ',')
                                       within group (order by null) || ']', 384, int8)
               from dual connect by level <= 384)
from   dual connect by level <= 2000;

insert into size_binary          -- 384 bits = 48 bytes per vector
select level, (select to_vector('[' || listagg(trunc(dbms_random.value(0, 256)), ',')
                                       within group (order by null) || ']', 384, binary)
               from dual connect by level <= 48)
from   dual connect by level <= 2000;
commit;

select segment_name as table_name, round(sum(bytes) / 1024 / 1024, 2) as mb
from   user_segments
where  segment_name in ('SIZE_F32', 'SIZE_INT8', 'SIZE_BINARY')
group  by segment_name
order  by mb desc;
