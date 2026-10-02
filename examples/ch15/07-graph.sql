-- @setup drop property graph if exists atlas_graph
create property graph atlas_graph
  vertex tables (
    customers key (customer_id),
    agents    key (agent_id),
    products  key (product_id) properties (product_id, name, category),
    tickets   key (ticket_id))
  edge tables (
    tickets as raised key (ticket_id)
      source      key (customer_id) references customers (customer_id)
      destination key (ticket_id)   references tickets (ticket_id)
      label raised no properties,
    tickets as handled key (ticket_id)
      source      key (agent_id)  references agents (agent_id)
      destination key (ticket_id) references tickets (ticket_id)
      label handled no properties,
    tickets as about key (ticket_id)
      source      key (ticket_id)  references tickets (ticket_id)
      destination key (product_id) references products (product_id)
      label about no properties);

-- who raised ticket 9, who handled it, and what it is about
select *
from   graph_table (atlas_graph
         match (c is customers) -[is raised]-> (t is tickets) <-[is handled]- (a is agents),
               (t) -[is about]-> (p is products)
         where t.ticket_id = 9
         columns (c.company, a.name as agent, p.name as product));
