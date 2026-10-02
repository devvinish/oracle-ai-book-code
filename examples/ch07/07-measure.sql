create or replace procedure measure_search (p_clause in varchar2 default null)
is
  l_distances  sys.odcinumberlist;
  l_tenth      number;
  l_hits       pls_integer := 0;
  l_results    pls_integer := 0;
  l_start      timestamp;
  l_exact_ms   number := 0;
  l_approx_ms  number := 0;
  l_queries    pls_integer := 0;
  l_sql        varchar2(400) :=
    'select vector_distance(embedding, :q1, cosine) from ticket_archive
     order by vector_distance(embedding, :q2, cosine)
     fetch approx first 10 rows only ' || p_clause;

  function ms (p_since in timestamp) return number is
  begin
    return extract(second from (systimestamp - p_since)) * 1000;
  end;
begin
  -- the 28 questions of Chapter 6: for each, the 10 nearest archived tickets
  for q in (select minilm as v from eval_questions where question_id <= 28) loop
    l_start := systimestamp;
    select vector_distance(embedding, q.v, cosine)
    bulk   collect into l_distances
    from   ticket_archive
    order  by vector_distance(embedding, q.v, cosine)
    fetch  exact first 10 rows only;
    l_exact_ms := l_exact_ms + ms(l_start);
    l_tenth := l_distances(10);

    l_start := systimestamp;
    execute immediate l_sql bulk collect into l_distances using q.v, q.v;
    l_approx_ms := l_approx_ms + ms(l_start);

    -- a result is right if it is as near as the 10th result of the exact search
    for i in 1 .. l_distances.count loop
      if l_distances(i) <= l_tenth + 1e-6 then l_hits := l_hits + 1; end if;
    end loop;
    l_results := l_results + 10;
    l_queries := l_queries + 1;
  end loop;

  dbms_output.put_line(nvl(p_clause, '(index default)'));
  dbms_output.put_line('  exact:       ' || to_char(l_exact_ms / l_queries, '990.0')
                       || ' ms per query');
  dbms_output.put_line('  approximate: ' || to_char(l_approx_ms / l_queries, '990.0')
                       || ' ms per query, '
                       || round(100 * l_hits / l_results) || '% of the right results');
end;
/

exec measure_search
