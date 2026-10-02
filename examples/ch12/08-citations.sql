-- the sources an answer cites, looked up in the sources it was given
with last_answer as (
  select answer, sources
  from   rag_log
  where  question = 'How many custom roles can an Enterprise account have?'
  order  by asked_at desc
  fetch  first 1 row only)
select s.n, s.source,
       case when instr(l.answer, '[' || s.n || ']') > 0 then 'cited' end as in_answer
from   last_answer l,
       json_table(l.sources, '$[*]' columns (n number path '$.n',
                                             source varchar2(60) path '$.source')) s
order  by s.n;
