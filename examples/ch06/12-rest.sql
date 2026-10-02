declare
  l_response  clob;
  l_vector    vector;
begin
  apex_util.set_workspace('ATLAS');      -- the workspace that owns the web credential

  apex_web_service.set_request_headers('Content-Type', 'application/json');
  l_response := apex_web_service.make_rest_request(
    p_url  => 'https://generativelanguage.googleapis.com/v1beta/models/'
              || 'gemini-embedding-001:embedContent',
    p_http_method => 'POST',
    p_body => '{"content": {"parts": [{"text": "I cannot sign in to my account"}]},
                "taskType": "RETRIEVAL_QUERY",
                "outputDimensionality": 768}',
    p_credential_static_id => 'credentials-for-gemini');

  dbms_output.put_line('HTTP status: ' || apex_web_service.g_status_code);
  dbms_output.put_line('Response:    ' || substr(replace(replace(l_response, chr(10)), ' '),
                                                 1, 70) || '...');

  -- the numbers are a JSON array: TO_VECTOR turns it into a vector
  l_vector := to_vector(json_query(l_response, '$.embedding.values' returning clob));
  dbms_output.put_line('Dimensions:  ' || vector_dimension_count(l_vector));
  dbms_output.put_line('Length:      ' || round(vector_norm(l_vector), 4));
end;
/
