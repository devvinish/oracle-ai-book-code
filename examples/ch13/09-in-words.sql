-- the rows, put into a sentence for the user
declare
  l_result json :=
    ask_data('What is the average satisfaction of closed tickets for each plan?');
begin
  dbms_output.put_line('SQL:    ' || json_value(l_result, '$.sql'));
  dbms_output.put_line('Answer: ' || generate(
    'Answer the question in one plain-text sentence from these query results. '
    || 'Question: ' || json_value(l_result, '$.question')
    || ' Results: ' || json_serialize(json_query(l_result, '$.rows')),
    'GEMINI_LITE'));
end;
/
