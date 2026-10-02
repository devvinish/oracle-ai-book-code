-- @expect-error
select generate('Name one color. Answer with one word.',
                p_options => json('{"generationConfig": {"maxOutputTokens": 20}}'))
         as answer
from   dual;

select generate('Name one color. Answer with one word.',
                p_options => json('{"generationConfig": {"maxOutputTokens": 20,
                                     "thinkingConfig": {"thinkingBudget": 0}}}')) as answer
from   dual;
