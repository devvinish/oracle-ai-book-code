-- @setup delete from llm_models where name = 'LLAMA_LOCAL'
insert into llm_models (name, params, thinking) values
  ('LLAMA_LOCAL',
   json('{"provider": "ollama",
          "host": "local",
          "url": "http://host.docker.internal:11434/api/generate",
          "model": "llama3.2:3b"}'), 'No');
commit;

select generate('Name the largest planet of the solar system. Answer with one word.',
                'LLAMA_LOCAL') as answer
from   dual;
