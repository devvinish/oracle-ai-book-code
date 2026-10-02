-- the agents with the most tickets resolved, counting Resolved only and Resolved or Closed
select a.name,
       count(case when t.status = 'Resolved' then 1 end)              as resolved,
       count(case when t.status in ('Resolved', 'Closed') then 1 end) as resolved_or_closed
from   agents a join tickets t on t.agent_id = a.agent_id
group  by a.name
order  by resolved_or_closed desc
fetch  first 4 rows only;
