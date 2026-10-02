-- the subjects of the tickets that no article is near: candidates for new articles
select t.subject, count(*) as tickets
from   tickets t
where  (select min(vector_distance(a.embedding, t.embedding, cosine))
        from   kb_articles a) >= 0.6
group  by t.subject
order  by tickets desc, t.subject
fetch  first 8 rows only;
