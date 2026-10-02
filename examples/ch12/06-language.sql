-- a question in Spanish: sources found by the English model, and by Gemini's
select ask('¿Puedo recuperar el dinero de un cobro duplicado?') as minilm_answer
from   dual;

select ask('¿Puedo recuperar el dinero de un cobro duplicado?', 'GEMINI') as gemini_answer
from   dual;
