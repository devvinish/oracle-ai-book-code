-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- a conversation: CHAT adds each question and answer to the messages
declare
  l_messages  apex_ai.t_chat_messages := apex_ai.c_chat_messages;
  l_system    clob := 'You are the support assistant of Atlas Software. '
                      || 'Answer in one sentence of plain text. '
                      || 'Facts: card refunds take 5 to 10 business days; '
                      || 'direct debit refunds take up to 3 business days.';
  l_answer    clob;
begin
  l_answer := apex_ai.chat(p_prompt => 'How long does a refund to my card take?',
                           p_system_prompt => l_system, p_messages => l_messages);
  dbms_output.put_line('1: ' || l_answer);
  l_answer := apex_ai.chat(p_prompt => 'And by direct debit?',
                           p_system_prompt => l_system, p_messages => l_messages);
  dbms_output.put_line('2: ' || l_answer);
  dbms_output.put_line('Messages in the conversation: ' || l_messages.count);
end;
/
