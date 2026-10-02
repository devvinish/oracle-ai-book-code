-- RAG with the local model: the instructions go in Ollama's system prompt
create or replace function ask_local (p_question in varchar2) return clob
is
  l_sources  json := retrieve(p_question);
  l_prompt   clob;
begin
  if l_sources is null then
    return 'I can only answer questions about Atlas products and services.';
  end if;
  select 'Sources:' || chr(10)
         || listagg('[' || n || '] ' || source || ': ' || text, chr(10) || chr(10))
              within group (order by n)
         || chr(10) || chr(10) || 'Question: ' || p_question
  into   l_prompt
  from   json_table(l_sources, '$[*]' columns (n      number         path '$.n',
                                               source varchar2(100)  path '$.source',
                                               text   varchar2(4000) path '$.text'));
  return generate(l_prompt, 'LLAMA_LOCAL', json_object(
    'system' value 'You are the support assistant of Atlas Software. '
                   || 'Answer the question using only the numbered sources. '
                   || 'Cite the sources you used, like [1] or [2]. '
                   || 'If the sources do not contain the answer, say exactly: '
                   || 'I could not find this in the Atlas knowledge base. '
                   || 'Answer in plain text, in at most four sentences.',
    'options' value json('{"temperature": 0}') returning json));
end;
/

select ask_local('Can I get my money back for a duplicate charge?') as answer from dual;
