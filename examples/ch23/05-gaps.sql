-- the questions the assistant could not answer, or whose answer did not help,
-- with the nearest source in the knowledge, nearest first
begin
  for r in (select case when q.helpful = 'N' then 'Not helpful' else q.outcome end reason,
                   n.distance, n.source, q.question
            from   ka_questions q
            cross  apply (select k.source,
                                 vector_distance(k.embedding, q.embedding, cosine) distance
                          from   knowledge k
                          order  by distance
                          fetch  first 1 row only) n
            where  q.outcome = 'Not found' or q.helpful = 'N'
            order  by n.distance) loop
    dbms_output.put_line(to_char(r.distance, '0.000') || '  '
                         || rpad(r.reason, 12) || r.source);
    dbms_output.put_line('        ' || r.question);
  end loop;
end;
/
