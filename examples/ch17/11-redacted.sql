-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- @setup delete from ai_request_log
-- every call of the application is redacted before it is sent
declare
  l_answer clob;
begin
  l_answer := apex_ai.generate(
    p_prompt => 'Repeat my contact details: olivia.walker@northwind.example, '
                || '+44 20 7946 0958.');
  dbms_output.put_line('Answer: ' || l_answer);
end;
/

select message as what_was_sent from ai_request_log order by logged_at;
