-- the tokens of one call, from Gemini's own count (the REST API of Chapter 10)
create or replace function token_usage (
  p_prompt  in clob,
  p_model   in varchar2 default 'gemini-flash-latest',
  p_config  in varchar2 default null           -- generationConfig, as JSON text
) return json
is
  l_body      clob;
  l_response  clob;
begin
  select json_object('contents' value json_array(json_object('parts' value
                       json_array(json_object('text' value p_prompt returning clob))
                       returning clob) returning clob),
                     'generationConfig' value nvl(p_config, '{}') format json
                     returning clob)
  into   l_body
  from   dual;

  apex_util.set_workspace('ATLAS');
  for attempt in 1 .. 3 loop                    -- a busy provider answers without usage
    apex_web_service.set_request_headers('Content-Type', 'application/json');
    l_response := apex_web_service.make_rest_request(
      p_url  => 'https://generativelanguage.googleapis.com/v1beta/models/' || p_model
                || ':generateContent',
      p_http_method => 'POST',
      p_body => l_body,
      p_credential_static_id => 'credentials-for-gemini');
    exit when json_exists(l_response, '$.usageMetadata');
    dbms_session.sleep(2 * attempt);
  end loop;
  return json_object(
    'prompt'   value json_value(l_response, '$.usageMetadata.promptTokenCount'),
    'thinking' value nvl(json_value(l_response, '$.usageMetadata.thoughtsTokenCount'), 0),
    'answer'   value json_value(l_response, '$.usageMetadata.candidatesTokenCount')
    returning json);
end;
/

-- a RAG prompt of Chapter 12, with thinking and without
with p as (
  select 'Sources:' || chr(10)
         || (select listagg(dbms_lob.substr(text, 4000), chr(10)) from knowledge
             where  source in ('Article KB-201', 'Article KB-202'))
         || chr(10) || 'Question: Can I get my money back for a duplicate charge?' as prompt
  from   dual)
select 'thinking on' as call, json_serialize(token_usage(prompt)) as tokens from p
union all
select 'thinking off',
       json_serialize(token_usage(prompt,
                        p_config => '{"thinkingConfig": {"thinkingBudget": 0}}'))
from   p;
