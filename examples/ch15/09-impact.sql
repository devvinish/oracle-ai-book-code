-- which Enterprise customers have reported problems like this one, and how often?
select g.company, count(*) as similar_tickets, max(g.created_at) as latest
from   graph_table (atlas_graph
         match (c is customers) -[is raised]-> (t is tickets)
         where c.plan = 'Enterprise'
         columns (c.company, t.created_at, t.embedding)) g
where  vector_distance(g.embedding,
         vector_embedding(all_minilm_l12_v2 using
           'The pipeline board keeps spinning and never shows our deals' as data),
         cosine) < 0.5
group  by g.company
order  by similar_tickets desc;
