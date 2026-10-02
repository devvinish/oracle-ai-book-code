with q as (select vector_embedding(all_minilm_l12_v2
                    using 'Our card was charged two times for one invoice' as data) as v
           from   dual)
select a.article_id, a.title,
       round(vector_distance(a.embedding, q.v, cosine), 3) as distance
from   kb_articles a, q
order  by distance
fetch  first 3 rows only;
