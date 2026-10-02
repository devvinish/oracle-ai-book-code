-- the Gemini models the key may call, with what they can do
select m.name, m.capabilities
from   json_table(
         dbms_vector_chain.list_models(json('{
           "provider": "googleai",
           "credential_name": "GEMINI_CRED",
           "url": "https://generativelanguage.googleapis.com/v1beta/models"}')),
         '$[*]' columns (name         varchar2(60)  path '$.name',
                         capabilities varchar2(100) format json path '$.capabilities')) m
where  m.name like '%latest%' or m.name like '%embedding%';
