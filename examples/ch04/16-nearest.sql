-- the three articles nearest to a ticket that is mostly about signing in
select article_id, k.title,
       round(vector_distance(a.topics, vector('[0.80, 0.10, 0.35]'), cosine), 4) as distance
from   article_topics a join kb_articles k using (article_id)
order  by distance
fetch  first 3 rows only;
