-- @setup delete from ai_job_log
-- @setup delete from tickets where ticket_id = 9004
-- @cleanup delete from tickets where ticket_id = 9004
-- a new ticket, saved at once; the job embeds and classifies it within a minute
insert into tickets (ticket_id, customer_id, product_id, subject, description,
                     priority, status, category, channel, created_at)
values (9004, 3, 1, 'Pipeline board empty',
        'Since this morning the deals board shows nothing at all, just a spinning wheel.',
        'High', 'Open', 'Bug', 'Chat', systimestamp);
commit;

select ticket_id, ai_category, vector_dimension_count(gemini_embedding) as gemini
from   tickets
where  ticket_id = 9004;

exec dbms_session.sleep(70)

select ai_category, ai_summary, vector_dimension_count(gemini_embedding) as gemini
from   tickets
where  ticket_id = 9004;

select to_char(logged_at, 'HH24:MI:SS') as at, task, status, done
from   ai_job_log
order  by logged_at;
