-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
-- the system prompt that APEX uses to write SQL from a question: its length and its sections
declare
  l_prompt clob := apex_ai.get_system_prompt(
                     p_prompt      => 'How many open tickets does each product have?',
                     p_prompt_type => apex_ai.c_prompt_sql_query);
begin
  dbms_output.put_line('Length: ' || length(l_prompt));
  dbms_output.put_line('Contains the column CUSTOMER_ID: '
                       || case when instr(upper(l_prompt), 'CUSTOMER_ID') > 0
                               then 'yes' else 'no' end);
  for i in 1 .. regexp_count(l_prompt, '^ *###[^' || chr(10) || ']*', 1, 'm') loop
    dbms_output.put_line(trim(regexp_substr(l_prompt, '^ *###[^' || chr(10) || ']*',
                                            1, i, 'm')));
  end loop;
end;
/
