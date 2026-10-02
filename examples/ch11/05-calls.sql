-- for each call: how many tickets went in, and how many came back
select call_id, attempts,
       regexp_count(prompt, '"ticket_id"')   as tickets_sent,
       regexp_count(response, '"ticket_id"') as tickets_answered,
       elapsed_ms
from   llm_calls
where  prompt like 'Classify each support ticket of Atlas Software.%'
order  by call_id;
