-- the same request, as is and with the form of the answer specified (first 500 characters)
select substr(generate(
         'How does a customer reset a forgotten password in a web application?',
         p_options => json('{"generationConfig":
                             {"thinkingConfig": {"thinkingBudget": 0}}}')), 1, 500)
         as default_answer
from   dual;

select substr(generate(
         'How does a customer reset a forgotten password in a web application? '
         || 'Answer in plain text, without Markdown, in at most three sentences.',
         p_options => json('{"generationConfig":
                             {"thinkingConfig": {"thinkingBudget": 0}}}')), 1, 500)
         as plain_answer
from   dual;
