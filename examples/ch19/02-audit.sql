-- what the agent changed, when, and with whose approval
select action_id, to_char(done_at, 'YYYY-MM-DD HH24:MI') as done_at, done_by,
       ticket_id, action, old_value, new_value
from   ai_actions
order  by action_id;
