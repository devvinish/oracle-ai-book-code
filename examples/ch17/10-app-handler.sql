-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- with the handler in the application's AI Attributes, every call uses it
declare
  l_answer clob;
begin
  l_answer := apex_ai.generate(
    p_prompt        => 'Is ticket 9 still open?',
    p_system_prompt => 'You are the support assistant of Atlas Software. '
                       || 'Answer in one sentence of plain text.',
    p_tools         => atlas_tools);
  dbms_output.put_line(l_answer);
end;
/
