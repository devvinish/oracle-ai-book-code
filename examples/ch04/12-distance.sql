-- a ticket about being charged twice: mostly billing, a little account and technical
with q as (select vector('[0.10, 0.90, 0.15]') as v from dual)
select a.article_id,
       round(vector_distance(a.topics, q.v, cosine), 4)    as cosine,
       round(vector_distance(a.topics, q.v, euclidean), 4) as euclidean,
       round(vector_distance(a.topics, q.v, dot), 4)       as dot,
       round(vector_distance(a.topics, q.v, manhattan), 4) as manhattan
from   article_topics a, q
order  by cosine;
