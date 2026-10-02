-- more questions from several customers, and how they ended
declare
  l_id number;
begin
  for q in (select * from json_table('[
              ["KESTREL",  "How do I reset my password if the e-mail never arrives?"],
              ["WILLOW",   "Is there a dark mode in Atlas Mobile?"],
              ["WILLOW",   "Can I pay by bank transfer instead of a card?"],
              ["MERIDIAN", "How do I import contacts from an Excel file?"],
              ["MERIDIAN", "My scheduled report did not arrive this morning."],
              ["KITE",     "Does Atlas CRM have an add-in for Outlook?"],
              ["KITE",     "How many API calls can I make per minute?"],
              ["SAFFRON",  "Can I pay with PayPal?"],
              ["SAFFRON",  "Can our invoices show our purchase order number?"]]',
              '$[*]' columns (asked_by varchar2(20) path '$[0]',
                              question varchar2(200) path '$[1]'))) loop
    l_id := ka_ask(q.question, q.asked_by);
  end loop;
end;
/
select question_id, asked_by, outcome, question
from   ka_questions
where  question_id > 3
order  by question_id;
