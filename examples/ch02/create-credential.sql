-- @setup begin dbms_vector_chain.drop_credential('GEMINI_CRED'); exception when others then null; end;
declare
  params json_object_t := json_object_t();
begin
  params.put('access_token', '<your-gemini-api-key>');
  dbms_vector_chain.create_credential(
    credential_name => 'GEMINI_CRED',
    params          => json(params.to_string));
end;
/
