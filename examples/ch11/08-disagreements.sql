select ticket_id, subject, category as agent, ai_category as model
from   tickets
where  category = 'Feature Request' and ai_category <> category
order  by ticket_id
fetch  first 5 rows only;
