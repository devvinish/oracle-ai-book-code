-- @setup drop table if exists rag_log purge
create table rag_log (
  asked_at  timestamp default systimestamp not null,
  question  varchar2(4000) not null,
  answer    clob,
  sources   json
);

create or replace function ask (
  p_question  in varchar2,
  p_model     in varchar2 default 'MINILM',   -- the embedding model that finds the sources
  p_llm       in varchar2 default 'GEMINI'    -- the language model that answers
) return clob
is
  c_instructions constant varchar2(1000) :=
    'You are the support assistant of Atlas Software. '
    || 'Answer the question using only the numbered sources. '
    || 'Cite the sources you used, like [1] or [2]. '
    || 'If the sources do not contain the answer, say exactly: '
    || 'I could not find this in the Atlas knowledge base. '
    || 'Answer in plain text, in at most four sentences, in the language of the question.';
  l_sources  json := retrieve(p_question, p_model);
  l_prompt   clob;
  l_answer   clob;

  procedure log_answer is
    pragma autonomous_transaction;
  begin
    insert into rag_log (question, answer, sources)
    values (p_question, l_answer, l_sources);
    commit;
  end;
begin
  if l_sources is null then
    -- nothing in the knowledge base is near the question: don't call the model
    l_answer := 'I can only answer questions about Atlas products and services.';
  else
    -- the sources, numbered, then the question
    select 'Sources:' || chr(10)
           || listagg('[' || n || '] ' || source || ': ' || text, chr(10) || chr(10))
                within group (order by n)
           || chr(10) || chr(10) || 'Question: ' || p_question
    into   l_prompt
    from   json_table(l_sources, '$[*]' columns (n      number         path '$.n',
                                                 source varchar2(100)  path '$.source',
                                                 text   varchar2(4000) path '$.text'));

    l_answer := generate(l_prompt, p_llm, json_object(
      'systemInstruction' value json_object('parts' value json_array(
                                  json_object('text' value c_instructions))),
      'generationConfig'  value json('{"temperature": 0,
                                       "thinkingConfig": {"thinkingBudget": 0}}')
      returning json));
  end if;

  log_answer;
  return l_answer;
end;
/

select ask('Can I get my money back for a duplicate charge?') as answer from dual;
