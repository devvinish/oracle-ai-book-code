select dbms_vector_chain.utl_to_generate_text(
         'In one sentence, what does a help desk do?',
         json('{"provider": "googleai",
                "credential_name": "GEMINI_CRED",
                "url": "https://generativelanguage.googleapis.com/v1beta/models/",
                "model": "gemini-flash-latest:generateContent"}')) as answer
from   dual;
