set timing on
select vector_dimension_count(dbms_vector_chain.utl_to_embedding(
         'I cannot sign in to my account',
         json('{"provider": "googleai",
                "credential_name": "GEMINI_CRED",
                "url": "https://generativelanguage.googleapis.com/v1beta/models/",
                "model": "gemini-embedding-001"}'))) as gemini_dimensions
from   dual;

select vector_dimension_count(vector_embedding(all_minilm_l12_v2
         using 'I cannot sign in to my account' as data)) as minilm_dimensions
from   dual;
set timing off
