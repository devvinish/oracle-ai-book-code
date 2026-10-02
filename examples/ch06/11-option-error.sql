-- @expect-error
select vector_dimension_count(dbms_vector_chain.utl_to_embedding(
         'I cannot sign in to my account',
         json('{"provider": "googleai",
                "credential_name": "GEMINI_CRED",
                "url": "https://generativelanguage.googleapis.com/v1beta/models/",
                "model": "gemini-embedding-001",
                "outputDimensionality": 768}'))) as dimensions
from   dual;
