-- proposes changes to the knowledge base from the questions it could not answer
create or replace function ka_suggest_articles return clob
is
  l_gaps clob;
begin
  select listagg('- ' || q.question || ' (nearest source: ' || n.source
                 || ', distance ' || to_char(n.distance, 'fm0.000') || ')', chr(10))
           within group (order by n.distance)
  into   l_gaps
  from   ka_questions q
  cross  apply (select k.source,
                       vector_distance(k.embedding, q.embedding, cosine) as distance
                from   knowledge k
                order  by distance
                fetch  first 1 row only) n
  where  q.outcome = 'Not found' or q.helpful = 'N';

  if l_gaps is null then
    return 'There are no unanswered questions.';
  end if;
  return generate(
    'Customers asked the Atlas support assistant these questions, and its knowledge base '
    || 'did not answer them well. Each question shows the nearest source in the knowledge '
    || 'base; a distance below 0.35 means that source is about the same subject.' || chr(10)
    || l_gaps || chr(10) || chr(10)
    || 'Propose at most five changes to the knowledge base. For each, write one line that '
    || 'starts with "Extend" and the name of a nearby article, or with "New article" and a '
    || 'title, followed by the questions it would answer. Plain text, no Markdown.',
    'GEMINI',
    json('{"generationConfig": {"thinkingConfig": {"thinkingBudget": 0}}}'));
end;
/
select ka_suggest_articles as suggestions;
