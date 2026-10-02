-- answers a question with ASK, and records it for the assistant's page and its review
create or replace function ka_ask (
  p_question in varchar2,
  p_user     in varchar2
) return number
is
  l_answer    clob;
  l_sources   json;
  l_embedding vector;
  l_id        ka_questions.question_id%type;
begin
  l_answer := ask(p_question);

  -- the sources that ASK gave the model, from its log
  select sources into l_sources
  from   rag_log
  where  question = p_question
  order  by asked_at desc
  fetch  first 1 row only;

  select vector_embedding(all_minilm_l12_v2 using p_question as data)
  into   l_embedding;

  insert into ka_questions (asked_by, question, answer, sources, outcome, embedding)
  values (p_user, p_question, l_answer, l_sources,
          case when l_answer like 'I could not find this%' then 'Not found'
               when l_answer like 'I can only answer%'     then 'Off topic'
               else 'Answered' end,
          l_embedding)
  returning question_id into l_id;
  return l_id;
end;
/
