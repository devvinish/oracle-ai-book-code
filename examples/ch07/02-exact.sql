select archive_id, subject,
       round(vector_distance(embedding,
             vector_embedding(all_minilm_l12_v2
               using 'The invoice was paid two times by mistake' as data), cosine), 3)
         as distance
from   ticket_archive
order  by distance
fetch  first 5 rows only;
