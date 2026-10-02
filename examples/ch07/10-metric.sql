-- the index was built for COSINE; this search asks for EUCLIDEAN
explain plan for
select archive_id
from   ticket_archive
order  by vector_distance(embedding, :query_vector, euclidean)
fetch  approx first 5 rows only;

select lpad(' ', 2 * depth) || operation || ' ' || options as operation, object_name
from   plan_table
order  by id;
