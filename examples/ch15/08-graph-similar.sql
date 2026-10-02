-- the paths of the graph, ranked by the meaning of the ticket on them
select g.company, g.plan, g.agent,
       round(vector_distance(g.embedding,
             vector_embedding(all_minilm_l12_v2 using
               'The pipeline board keeps spinning and never shows our deals' as data),
             cosine), 3) as distance
from   graph_table (atlas_graph
         match (c is customers) -[is raised]-> (t is tickets) <-[is handled]- (a is agents)
         columns (c.company, c.plan, a.name as agent, t.embedding)) g
order  by distance
fetch  first 5 rows only;
