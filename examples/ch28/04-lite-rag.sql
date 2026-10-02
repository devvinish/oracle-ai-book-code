-- the 14 document questions answered with Gemini Flash and with Flash Lite
with keys (question_id, key_fact) as (
  values (1, '20'), (2, '7 days'), (3, '20 MB'), (4, '180 days'), (5, '3 days'),
         (6, '3 business days'), (7, 'ten months'), (8, '11'), (9, '15 minutes'),
         (10, '100'), (11, '30 June 2027'), (12, '5 GB'), (13, '14 September 2026'),
         (14, '40')),
models (llm) as (values ('GEMINI'), ('GEMINI_LITE'))
select m.llm, count(*) as questions,
       count(case when instr(a.answer, k.key_fact) > 0 then 1 end) as with_key_fact,
       count(case when regexp_like(a.answer, '\[\d') then 1 end) as with_citation
from   models m cross join doc_questions q
join   keys k on k.question_id = q.question_id
cross  apply (select ask(q.question, 'MINILM', m.llm) as answer from dual) a
group  by m.llm;
