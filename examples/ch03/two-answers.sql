-- the same prompt, sent twice
select dbms_vector_chain.utl_to_generate_text(
         'Suggest a short subject line for a ticket about a duplicate credit card charge.',
         json('{"provider": "googleai", "credential_name": "GEMINI_CRED",
                "url": "https://generativelanguage.googleapis.com/v1beta/models/",
                "model": "gemini-flash-latest:generateContent"}')) as first_answer
from   dual;

select dbms_vector_chain.utl_to_generate_text(
         'Suggest a short subject line for a ticket about a duplicate credit card charge.',
         json('{"provider": "googleai", "credential_name": "GEMINI_CRED",
                "url": "https://generativelanguage.googleapis.com/v1beta/models/",
                "model": "gemini-flash-latest:generateContent"}')) as second_answer
from   dual;
