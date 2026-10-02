-- a customer writes in Spanish: translate for the agent, and translate the reply back
select generate('Translate this customer message to English. Answer with the translation '
                || 'only: Hola, desde ayer la aplicación del móvil se cierra al abrirla. '
                || 'Usamos la versión 3.9.0. ¿Hay alguna solución?', 'GEMINI_LITE')
         as for_the_agent
from   dual;

select generate('Translate this support reply to Spanish, keeping the version numbers. '
                || 'Answer with the translation only: Version 3.9.1 fixes the crash. Until '
                || 'it reaches your app store, sign out and sign in again.', 'GEMINI_LITE')
         as for_the_customer
from   dual;
