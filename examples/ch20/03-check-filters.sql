-- the filters the report applied, as SQL: the same single ticket
select ticket_id, subject, priority, status, category
from   tickets
where  status = 'Open' and category = 'Billing' and priority in ('High', 'Urgent')
order  by created_at desc;
