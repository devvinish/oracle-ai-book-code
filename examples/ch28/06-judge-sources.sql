-- the same answers, checked against the sources ASK gave the model (from RAG_LOG)
alter table judged_answers add (faithful varchar2(10));

update judged_answers j
set    faithful = (
         select json_value(generate(
                  'You check the answers of a support assistant. The assistant was given '
                  || 'these sources: '
                  || (select json_serialize(json_query(r.sources, '$[*].text' with wrapper)
                                            returning clob)
                      from   rag_log r
                      where  r.question = j.question
                      order  by r.asked_at desc
                      fetch  first 1 row only)
                  || chr(10) || 'Answer: ' || j.answer
                  || chr(10)
                  || 'Is every statement of the answer supported by the sources?',
                  'GEMINI',
                  json('{"generationConfig": {"temperature": 0,
                         "responseMimeType": "application/json",
                         "responseSchema": {"type": "OBJECT", "required": ["faithful"],
                           "properties": {"faithful": {"type": "STRING",
                                                       "enum": ["yes", "no"]}}}}}')),
                  '$.faithful')
         from   dual);
commit;

select count(*) as answers,
       count(case when unsupported = 'yes' then 1 end) as unsupported_by_article,
       count(case when faithful = 'no' then 1 end) as unsupported_by_sources
from   judged_answers;
