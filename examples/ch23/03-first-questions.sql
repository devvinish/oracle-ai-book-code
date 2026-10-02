-- @setup truncate table ka_questions
-- @setup alter table ka_questions modify question_id generated always as identity (start with 1)
-- asks three questions as a customer, and shows what was recorded
declare
  l_id number;
begin
  for q in (select column_value as question
            from   sys.odcivarchar2list(
                     'Why was my card charged twice this month?',
                     'Can I pay my invoices with PayPal?',
                     'What is the capital of France?')) loop
    l_id := ka_ask(q.question, 'KESTREL');
  end loop;
  for r in (select * from ka_questions order by question_id) loop
    dbms_output.put_line('Question ' || r.question_id || ': ' || r.question);
    dbms_output.put_line('Outcome: ' || r.outcome);
    dbms_output.put_line('Answer: ' || r.answer);
    dbms_output.put_line('');
  end loop;
end;
/
