-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- the session of Atlas Support is an agent's: the internal document is among the sources
declare
  l_answer clob;
begin
  dbms_output.put_line('Audience: ' || sys_context('ATLAS_CTX', 'AUDIENCE'));
  l_answer := apex_ai.generate(
                p_agent_static_id => 'atlas-assistant',
                p_prompt => 'How large a goodwill credit can be given without approval?');
  dbms_output.put_line('Answer:   ' || l_answer);
end;
/
