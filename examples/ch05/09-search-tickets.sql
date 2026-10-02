with q as (select vector_embedding(all_minilm_l12_v2
                    using 'I was charged two times for one invoice' as data) as v
           from   dual)
select t.ticket_id, t.subject,
       round(vector_distance(t.embedding, q.v, cosine), 3) as distance
from   tickets t, q
order  by distance
fetch  first 5 rows only;
