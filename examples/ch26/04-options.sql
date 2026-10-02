-- Ollama's names for the settings of Chapter 10: system, options, and format
select generate('Can I get my money back for a duplicate charge?', 'LLAMA_LOCAL',
         json_object('system'  value 'You are the support assistant of Atlas Software. '
                                     || 'Answer in at most two sentences, in plain text.',
                     'options' value json('{"temperature": 0}') returning json)) as answer
from   dual;

select generate('Classify this support ticket: '
                || '"Since the update, nobody on our team can sign in."', 'LLAMA_LOCAL',
         json('{"options": {"temperature": 0},
                "format": {"type": "object", "required": ["category"],
                           "properties": {"category": {"type": "string",
                             "enum": ["Account", "Billing", "Bug", "Question",
                                      "Feature Request"]}}}}')) as answer
from   dual;
