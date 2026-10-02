-- a tool: the status of a ticket, for the model to call when it needs it
create or replace procedure ticket_status_tool (
  p_param   in            apex_ai.t_tool_exec_param,
  p_result  in out nocopy apex_ai.t_tool_exec_result)
is
  l_ticket_id number := p_param.args_json.get_number('ticket_id');
begin
  select json_object('ticket_id' value ticket_id, 'subject' value subject,
                     'status' value status, 'priority' value priority,
                     'created_at' value to_char(created_at, 'YYYY-MM-DD'))
  into   p_result.result
  from   tickets
  where  ticket_id = l_ticket_id;
exception
  when no_data_found then
    p_result.result := '{"error": "There is no ticket ' || l_ticket_id || '."}';
end;
/

-- the tool's definition for the model: its name, what it does, and its parameters
create or replace function atlas_tools return apex_ai.t_tools
is
begin
  return apex_ai.t_tools(
    apex_ai.t_tool(
      name               => 'get_ticket_status',
      description        => 'Returns the subject, status, priority, and creation date '
                            || 'of a support ticket',
      parameters         => apex_ai.t_tool_parameters(
                              apex_ai.t_tool_parameter(
                                name        => 'ticket_id',
                                description => 'The number of the ticket',
                                data_type   => apex_ai.c_tool_param_type_number)),
      callback_procedure => 'ticket_status_tool'));
end;
/
