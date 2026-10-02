-- the two knowledge base articles nearest to ticket 9
select a.article_id,
       round(vector_distance(a.embedding, t.embedding, cosine), 3) as distance,
       a.title
from   kb_articles a, tickets t
where  t.ticket_id = 9
order  by distance
fetch  first 2 rows only;
