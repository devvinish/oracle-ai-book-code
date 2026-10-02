-- the 100 test tickets of Chapter 14, classified one by one by the local model
set timing on
select count(*) as tickets,
       count(case when json_value(generate(
                'Classify this support ticket of Atlas Software. Categories: Account '
                || '(sign-in, users, security), Billing (invoices, payments, plans, tax), '
                || 'Bug (something does not work), Question (how to do something), '
                || 'Feature Request (something that does not exist). Ticket: '
                || t.subject || '. ' || t.description,
                'LLAMA_LOCAL',
                json('{"options": {"temperature": 0},
                       "format": {"type": "object", "required": ["category"],
                         "properties": {"category": {"type": "string",
                           "enum": ["Account", "Billing", "Bug", "Question",
                                    "Feature Request"]}}}}')), '$.category') = t.category
                  then 1 end) as local_right,
       count(case when t.ai_category = t.category then 1 end) as gemini_right
from   tickets t
where  mod(t.ticket_id, 4) = 0;
set timing off
