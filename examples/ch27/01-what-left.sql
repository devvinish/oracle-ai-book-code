-- everything GENERATE sent to a provider is in the log: how much, to which model
select model, count(*) as calls,
       round(sum(dbms_lob.getlength(prompt)) / 1024) as prompt_kb,
       min(called_at) as first_call
from   llm_calls
group  by model
order  by calls desc;
