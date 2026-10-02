-- @setup begin dbms_vector_chain.drop_credential('LOCAL_CRED'); exception when others then null; end;
-- a local server needs no key, but the openai provider wants a credential: any value
begin
  dbms_vector_chain.create_credential(
    credential_name => 'LOCAL_CRED',
    params          => json('{"access_token": "none"}'));
end;
/

select dbms_vector_chain.utl_to_generate_text(
         'Name the largest planet of the solar system. Answer with one word.',
         json('{"provider": "openai",
                "credential_name": "LOCAL_CRED",
                "url": "http://host.docker.internal:11434/v1/chat/completions",
                "model": "llama3.2:3b"}')) as answer
from   dual;
