with q as (select vector_embedding(all_minilm_l12_v2 using
                    'How many custom roles can an Enterprise account create?' as data) as v
           from   dual)
select d.doc_id, c.chunk_id,
       round(vector_distance(c.embedding, q.v, cosine), 3) as distance,
       regexp_replace(substr(c.chunk_text, 1, 55), '\s+', ' ') || '...' as chunk_start
from   doc_chunks c join atlas_documents d on d.doc_id = c.doc_id, q
order  by distance
fetch  first 3 rows only;
