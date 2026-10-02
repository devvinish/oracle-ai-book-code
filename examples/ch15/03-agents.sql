-- who has solved problems like this new one, and how fast?
with similar as (
  select t.agent_id, t.created_at, t.resolved_at, t.satisfaction
  from   tickets t
  where  t.resolved_at is not null
  order  by vector_distance(t.embedding,
              vector_embedding(all_minilm_l12_v2 using
                'The pipeline board keeps spinning and never shows our deals' as data),
              cosine)
  fetch  first 20 rows only)
select a.name as agent, count(*) as similar_tickets,
       round(avg(extract(day from (s.resolved_at - s.created_at)) * 24
                 + extract(hour from (s.resolved_at - s.created_at)))) as avg_hours,
       round(avg(s.satisfaction), 1) as avg_satisfaction
from   similar s join agents a on a.agent_id = s.agent_id
group  by a.name
order  by similar_tickets desc, avg_hours;
