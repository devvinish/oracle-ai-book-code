-- the plan of an approximate search, with the long names of the index tables shortened
explain plan for
select archive_id
from   ticket_archive
order  by vector_distance(embedding, :query_vector, cosine)
fetch  approx first 5 rows only;

select lpad(' ', 2 * depth) || operation || ' ' || options as operation,
       regexp_replace(object_name, '^VECTOR\$TICKET_ARCHIVE_IVF\$.*\$', 'VECTOR$...$')
         as object_name
from   plan_table
order  by id;
