-- one call to Gemini for each of five tickets
set timing on
select ticket_id, subject,
       generate('Rewrite this support ticket subject in at most five words, '
                || 'plain text only: ' || subject,
                'GEMINI_LITE') as short_subject
from   tickets
where  ticket_id <= 5
order  by ticket_id;
set timing off

select count(*) as calls, sum(elapsed_ms) as total_ms
from   llm_calls
where  model = 'GEMINI_LITE';
