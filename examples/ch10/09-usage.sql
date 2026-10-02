-- calling Gemini's REST API directly, to see the tokens a call used
declare
  l_response clob;
begin
  apex_util.set_workspace('ATLAS');
  apex_web_service.set_request_headers('Content-Type', 'application/json');
  l_response := apex_web_service.make_rest_request(
    p_url  => 'https://generativelanguage.googleapis.com/v1beta/models/'
              || 'gemini-flash-latest:generateContent',
    p_http_method => 'POST',
    p_body => '{"contents": [{"parts": [{"text":
                 "In at most ten words: why do customers contact a help desk?"}]}]}',
    p_credential_static_id => 'credentials-for-gemini');

  dbms_output.put_line('Answer:   ' || json_value(l_response,
                         '$.candidates[0].content.parts[0].text' returning clob));
  dbms_output.put_line('Model:    ' || json_value(l_response, '$.modelVersion'));
  dbms_output.put_line('Prompt:   '
    || json_value(l_response, '$.usageMetadata.promptTokenCount') || ' tokens');
  dbms_output.put_line('Thinking: '
    || json_value(l_response, '$.usageMetadata.thoughtsTokenCount') || ' tokens');
  dbms_output.put_line('Answer:   '
    || json_value(l_response, '$.usageMetadata.candidatesTokenCount') || ' tokens');
end;
/
