-- the product version each customer mentions: by the model, and by a regular expression
with batch as (
  select ticket_id, dbms_lob.substr(description, 4000) as description
  from   tickets
  where  ticket_id between 1 and 30),
extracted as (
  select j.ticket_id, j.version
  from   json_table(
           generate('For each ticket, extract the product version the customer says '
                    || 'they use, such as 5.2 or 8.4.1, or null if the ticket mentions '
                    || 'none. '
                    || 'Tickets: '
                    || (select json_arrayagg(json_object('ticket_id' value ticket_id,
                                                         'text' value description
                                                         returning clob) returning clob)
                        from   batch),
                    'GEMINI',
                    json('{"generationConfig": {"temperature": 0,
                      "thinkingConfig": {"thinkingBudget": 0},
                      "responseMimeType": "application/json",
                      "responseSchema": {"type": "ARRAY", "items": {"type": "OBJECT",
                        "properties": {"ticket_id": {"type": "INTEGER"},
                                       "version": {"type": "STRING", "nullable": true}},
                        "required": ["ticket_id", "version"]}}}}')),
           '$[*]' columns (ticket_id number path '$.ticket_id',
                           version varchar2(20) path '$.version')) j)
select count(*) as tickets,
       count(regexp_substr(b.description, '\d+\.\d+(\.\d+)?')) as with_version,
       count(case when e.version = regexp_substr(b.description, '\d+\.\d+(\.\d+)?')
                  then 1 end) as model_agrees,
       count(case when e.version is null
                   and regexp_substr(b.description, '\d+\.\d+(\.\d+)?') is null
                  then 1 end) as both_none
from   batch b left join extracted e on e.ticket_id = b.ticket_id;
