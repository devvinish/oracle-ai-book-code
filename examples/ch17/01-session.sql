-- outside a page, APEX_AI needs a session of the application whose AI settings it uses
begin
  apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN');
end;
/

declare
  l_answer clob;
begin
  dbms_output.put_line('AI enabled: '
                       || case when apex_ai.is_enabled then 'Yes' else 'No' end);
  l_answer := apex_ai.generate(
                p_prompt            => 'Name the largest planet. One word.',
                p_service_static_id => 'gemini');
  dbms_output.put_line('Answer:     ' || l_answer);
end;
/
