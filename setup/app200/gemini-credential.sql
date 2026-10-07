-- Made by tools/publish/make_app200_setup.py of the book from the examples; do not edit.
-- Stores your Gemini API key in the database credential GEMINI_CRED (Chapter 2). install.sql runs
-- it when GEMINI_CRED is missing; run it yourself as ATLAS to change the key.
set verify off feedback off
accept gemini_key char prompt '    Your Gemini API key (it is not shown): ' hide
begin
  dbms_vector_chain.drop_credential('GEMINI_CRED');
exception
  when others then null;
end;
/
declare
  params json_object_t := json_object_t();
begin
  params.put('access_token', '&gemini_key');
  dbms_vector_chain.create_credential(
    credential_name => 'GEMINI_CRED',
    params          => json(params.to_string));
end;
/
undefine gemini_key
prompt     GEMINI_CRED created.
