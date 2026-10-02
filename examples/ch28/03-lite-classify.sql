-- the 100 test tickets, classified in batches of 25 by a model; how many like the agents?
create or replace function agreement (p_model in varchar2) return varchar2
is
  l_tickets clob;
  l_answer  clob;
  l_right   pls_integer := 0;
  l_start   timestamp := systimestamp;
begin
  for b in 0 .. 3 loop
    select json_arrayagg(json_object('ticket_id' value ticket_id,
                                     'text' value subject || '. ' || description
                                     returning clob) returning clob)
    into   l_tickets
    from   tickets
    where  mod(ticket_id, 4) = 0 and mod(ticket_id / 4, 4) = b;

    l_answer := generate(
      'Classify each support ticket of Atlas Software. '
      || 'Categories: Account (sign-in, users, security), '
      || 'Billing (invoices, payments, plans, tax), Bug (something does not work), '
      || 'Question (how to do something), Feature Request (something that does not exist). '
      || 'Tickets: ' || l_tickets,
      p_model,
      json('{"generationConfig": {"temperature": 0, "thinkingConfig": {"thinkingBudget": 0},
             "responseMimeType": "application/json",
             "responseSchema": {"type": "ARRAY", "items": {"type": "OBJECT",
               "required": ["ticket_id", "category"], "properties": {
                 "ticket_id": {"type": "INTEGER"},
                 "category": {"type": "STRING",
                              "enum": ["Account", "Billing", "Bug", "Question",
                                       "Feature Request"]}}}}}}'));
    select l_right + count(*) into l_right
    from   json_table(l_answer, '$[*]' columns (ticket_id number path '$.ticket_id',
                                               category varchar2(20) path '$.category')) j
    join   tickets t on t.ticket_id = j.ticket_id and t.category = j.category;
  end loop;
  return l_right || ' of 100 right in '
         || round(extract(minute from (systimestamp - l_start)) * 60
                  + extract(second from (systimestamp - l_start)), 1) || ' seconds';
end;
/

select 'GEMINI' as model, agreement('GEMINI') as result from dual
union all
select 'GEMINI_LITE', agreement('GEMINI_LITE') from dual;
