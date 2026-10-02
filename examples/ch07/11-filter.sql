-- the nearest archived tickets about Atlas Mobile (product 3) only
select archive_id, product_id, subject,
       round(vector_distance(embedding,
             vector_embedding(all_minilm_l12_v2
               using 'The app quits as soon as it starts' as data), cosine), 3) as distance
from   ticket_archive
where  product_id = 3
order  by distance
fetch  approx first 5 rows only;
