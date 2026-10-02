-- the prompt of the last call to Gemini: what the model saw
select substr(prompt, 1, 900) || '...' as prompt
from   llm_calls
order  by call_id desc
fetch  first 1 row only;
