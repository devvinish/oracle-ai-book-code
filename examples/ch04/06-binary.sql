-- 170 = 10101010 and 15 = 00001111: two bytes hold 16 binary dimensions
select to_vector('[170, 15]', 16, binary)                         as bits,
       vector_dimension_count(to_vector('[170, 15]', 16, binary)) as dims
from   dual;

-- @expect-error
select to_vector('[170, 15]', 12, binary) from dual;
