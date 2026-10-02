-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- the same call, with the request handler
declare
  l_answer clob;
begin
  l_answer := apex_ai.generate(
    p_prompt        => 'What is the status of ticket 15, and what was it about?',
    p_system_prompt => 'You are the support assistant of Atlas Software. '
                       || 'Answer in one sentence of plain text.',
    p_request_handler_procedure => 'atlas_ai_request_handler',
    p_tools         => atlas_tools);
  dbms_output.put_line(l_answer);
end;
/
