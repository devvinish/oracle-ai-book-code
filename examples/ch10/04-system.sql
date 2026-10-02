select generate(
         'Can I get my money back for a duplicate charge?',
         p_options => json('{"systemInstruction": {"parts": [{"text": "'
           || 'You are the support assistant of Atlas Software. '
           || 'Answer in at most two sentences, in plain text, without Markdown. '
           || 'If you do not know, say so."}]}}')) as answer
from   dual;
