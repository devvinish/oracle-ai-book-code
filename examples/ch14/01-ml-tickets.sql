-- @setup drop table if exists ml_tickets purge
-- the tickets with what a model may learn from; every 4th ticket is kept for testing
create table ml_tickets as
select t.ticket_id, t.category, t.priority, c.plan, t.product_id, t.channel, t.embedding,
       case when mod(t.ticket_id, 4) = 0 then 'Test' else 'Train' end as data_set
from   tickets t join customers c on c.customer_id = t.customer_id;

select data_set, count(*) as tickets from ml_tickets group by data_set order by data_set;
