-- for every ticket, the distance of its nearest knowledge base article
with nearest as (
  select t.ticket_id,
         (select min(vector_distance(a.embedding, t.embedding, cosine))
          from   kb_articles a) as distance
  from   tickets t)
select case when distance < 0.4 then '1: answered by an article'
            when distance < 0.6 then '2: partly covered'
            else '3: no article near' end as coverage,
       count(*) as tickets
from   nearest
group  by case when distance < 0.4 then '1: answered by an article'
               when distance < 0.6 then '2: partly covered'
               else '3: no article near' end
order  by coverage;
