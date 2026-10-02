-- @setup drop table if exists new_tickets purge
-- eight tickets about problems that no Atlas ticket has described, with the right category
create table new_tickets (n number, text varchar2(200), category varchar2(20));
insert into new_tickets values
  (1, 'Our GDPR officer needs to know in which country our data is stored.', 'Question'),
  (2, 'The search box in contacts ignores accents, so we cannot find Muller.', 'Bug'),
  (3, 'Please add a dark mode to the desktop app for our night shift.', 'Feature Request'),
  (4, 'We were charged in dollars although our account is set to euros.', 'Billing'),
  (5, 'A former employee still has access after we removed her from the team.', 'Account'),
  (6, 'Exported CSV files open with broken characters in Excel.', 'Bug'),
  (7, 'Can we get an invoice addressed to our parent company instead?', 'Billing'),
  (8, 'Would it be possible to schedule reports in our local time zone?',
      'Feature Request');
commit;

create or replace function llm_category (p_text in varchar2) return varchar2
is
begin
  return json_value(generate(
    'Classify this support ticket of Atlas Software. '
    || 'Categories: Account (sign-in, users, security), '
    || 'Billing (invoices, payments, plans, tax), Bug (something does not work), '
    || 'Question (how to do something), Feature Request (something that does not exist). '
    || 'Ticket: ' || p_text,
    'GEMINI',
    json('{"generationConfig": {"temperature": 0, "thinkingConfig": {"thinkingBudget": 0},
      "responseMimeType": "application/json",
      "responseSchema": {"type": "OBJECT", "required": ["category"], "properties":
        {"category": {"type": "STRING", "enum": ["Account", "Billing", "Bug", "Question",
                                                 "Feature Request"]}}}}}')),
    '$.category');
end;
/

with e as (
  select n, text, category,
         vector_embedding(all_minilm_l12_v2 using text as data) as embedding
  from   new_tickets)
select n, category,
       prediction(category_svm using embedding) as classifier,
       round(prediction_probability(category_svm using embedding), 2) as probability,
       llm_category(text) as llm
from   e
order  by n;
