-- @expect-error
-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- a tool that requires confirmation, called where no one can confirm
declare
  l_answer clob;
begin
  l_answer := apex_ai.generate(
    p_agent_static_id => 'atlas-triage-agent',
    p_prompt => 'Kestrel Health says their integration stopped receiving events. '
                || 'Raise the priority of their open ticket about it to High.');
  dbms_output.put_line(l_answer);
end;
/

select ticket_id, priority from tickets where ticket_id = 11;
select count(*) as actions from ai_actions;
