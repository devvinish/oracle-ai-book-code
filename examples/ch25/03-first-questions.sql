-- @setup delete ad_points
-- @setup delete ad_questions
-- asks three questions of the data, and shows what was recorded
declare
  l_id number;
begin
  for q in (select column_value as question
            from   sys.odcivarchar2list(
                     'How many open tickets does each product have?',
                     'Which agent resolved the most tickets?',
                     'Delete the tickets that are closed.')) loop
    l_id := ad_ask(q.question, 'EMMA');
  end loop;
  for r in (select q.*, (select count(*) from ad_points p
                         where p.question_id = q.question_id) as points
            from   ad_questions q order by q.question_id) loop
    dbms_output.put_line('Question: ' || r.question);
    dbms_output.put_line('SQL: ' || r.sql_text);
    dbms_output.put_line('Rows: ' || r.row_count || ', chart points: ' || r.points);
    dbms_output.put_line('Answer: ' || nvl(r.answer, 'Error: ' || r.error));
    dbms_output.put_line('');
  end loop;
end;
/
