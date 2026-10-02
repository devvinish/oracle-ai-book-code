-- the first call loads the model into memory; the second finds it there
set timing on
select dbms_vector_chain.utl_to_generate_text(
         'In one sentence: why do customers contact a help desk?',
         json('{"provider": "ollama",
                "host": "local",
                "url": "http://host.docker.internal:11434/api/generate",
                "model": "llama3.2:3b"}')) as answer
from   dual;

select dbms_vector_chain.utl_to_generate_text(
         'In one sentence: why do customers contact a help desk?',
         json('{"provider": "ollama",
                "host": "local",
                "url": "http://host.docker.internal:11434/api/generate",
                "model": "llama3.2:3b"}')) as answer
from   dual;
set timing off
