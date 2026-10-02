with e as (
  select dbms_vector_chain.utl_to_embedding(
           'I cannot sign in to my account',
           json('{"provider": "googleai", "credential_name": "GEMINI_CRED",
                  "url": "https://generativelanguage.googleapis.com/v1beta/models/",
                  "model": "gemini-embedding-001"}')) as v
  from   dual
)
select vector_dimension_count(v)                          as dimensions,
       vector_dimension_format(v)                         as format,
       round(vector_norm(v), 4)                           as length,
       substr(from_vector(v returning clob), 1, 44) || '...' as first_numbers
from   e;
