-- @setup drop table if exists ai_request_log purge
create table ai_request_log (
  logged_at  timestamp default systimestamp,
  message    clob
);

-- called before every AI request of Atlas Support:
-- 1. tool results go to Gemini as user messages, with the tool-call turn left out
-- 2. every message is redacted (Chapter 27), and logged as sent
create or replace procedure atlas_ai_request_handler (
  p_param   in            apex_ai.t_chat_request_handler_param,
  p_result  in out nocopy apex_ai.t_chat_request_handler_result)
is
  l_in   apex_ai.t_chat_messages := p_result.request.messages;
  l_out  apex_ai.t_chat_messages;
  i      pls_integer := l_in.first;

  procedure log_message (p_message in clob) is
    pragma autonomous_transaction;
  begin
    insert into ai_request_log (message) values (p_message);
    commit;
  end;
begin
  while i is not null loop
    if l_in(i).chat_role = apex_ai.c_role_tool then
      l_out(l_out.count + 1).chat_role := apex_ai.c_role_user;
      l_out(l_out.count).message := 'Result of the tool call: ' || l_in(i).tool.content;
    elsif l_in(i).tool_calls is null or l_in(i).tool_calls.count = 0 then
      l_out(l_out.count + 1) := l_in(i);
    end if;
    i := l_in.next(i);
  end loop;

  for j in 1 .. l_out.count loop
    l_out(j).message := redact(l_out(j).message);
    log_message(l_out(j).message);
  end loop;
  p_result.request.messages := l_out;
end;
/
