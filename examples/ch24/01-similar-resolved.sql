-- the three resolved tickets nearest to ticket 9, with the agent's last comment on each
begin
  for r in (select t.ticket_id, t.subject,
                   vector_distance(t.embedding, x.embedding, cosine) as distance,
                   (select c.body
                    from   ticket_comments c
                    where  c.ticket_id = t.ticket_id and c.author_type = 'Agent'
                    order  by c.created_at desc
                    fetch  first 1 row only) as resolution
            from   tickets t, tickets x
            where  x.ticket_id = 9
            and    t.ticket_id <> x.ticket_id
            and    t.status in ('Resolved', 'Closed')
            order  by distance
            fetch  first 3 rows only) loop
    dbms_output.put_line('Ticket ' || r.ticket_id || ' (' || to_char(r.distance, 'fm0.000')
                         || '): ' || r.subject);
    dbms_output.put_line('Resolution: ' || r.resolution);
  end loop;
end;
/
