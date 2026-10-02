-- 10 dimensions, values only at positions 2 and 7
select to_vector('[10, [2, 7], [0.5, 0.25]]', 10, float32, sparse) as sparse_vector,
       from_vector(to_vector('[10, [2, 7], [0.5, 0.25]]', 10, float32, sparse)
                   returning varchar2(200) format dense)          as as_dense
from   dual;

-- @expect-error
select vector_distance(to_vector('[10, [2, 7], [0.5, 0.25]]', 10, float32, sparse),
                       to_vector('[0, 0.5, 0, 0, 0, 0, 0.25, 0, 0, 0]', 10, float32)) as d
from   dual;
