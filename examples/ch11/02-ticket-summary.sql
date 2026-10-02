-- ticket 15 and its conversation, summarized for the agent who takes it over
select generate(
         'Summarize this support ticket for the agent who takes it over: the problem, what '
         || 'was done, and what is still open. Plain text, at most three sentences.'
         || chr(10) || 'Customer: ' || t.description || chr(10)
         || (select listagg(c.author_type || ': ' || c.body, chr(10))
                      within group (order by c.created_at)
             from   ticket_comments c
             where  c.ticket_id = t.ticket_id),
         p_options => json('{"generationConfig":
                             {"thinkingConfig": {"thinkingBudget": 0}}}')) as handover
from   tickets t
where  t.ticket_id = 15;
