-- the tickets most like ticket 9, except ticket 9 itself
select t.ticket_id, t.subject, t.status,
       round(vector_distance(t.embedding, s.embedding, cosine), 3) as distance
from   tickets t, tickets s
where  s.ticket_id = 9
and    t.ticket_id <> s.ticket_id
order  by distance
fetch  first 5 rows only;
