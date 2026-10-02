-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- a conversation with the agent: its prompt, tools, and service come from Shared Components
declare
  l_messages  apex_ai.t_chat_messages := apex_ai.c_chat_messages;
  l_answer    clob;
begin
  l_answer := apex_ai.chat(p_agent_static_id => 'atlas-assistant',
                           p_prompt          => 'Can I get my money back for a duplicate '
                                                || 'charge?',
                           p_messages        => l_messages);
  dbms_output.put_line('1: ' || l_answer);
  l_answer := apex_ai.chat(p_agent_static_id => 'atlas-assistant',
                           p_prompt          => 'And what is the status of my ticket 15?',
                           p_messages        => l_messages);
  dbms_output.put_line('2: ' || l_answer);
end;
/
