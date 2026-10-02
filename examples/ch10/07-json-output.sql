-- the model must answer with JSON that follows a schema
select generate(
         'Classify this support ticket: "Since the update, nobody on our team can sign in. '
         || 'We get invalid credentials even after a password reset."',
         p_options => json('{"generationConfig": {
           "responseMimeType": "application/json",
           "responseSchema": {
             "type": "OBJECT",
             "properties": {
               "category": {"type": "STRING",
                            "enum": ["Account", "Billing", "Bug", "Question",
                                     "Feature Request"]},
               "priority": {"type": "STRING", "enum": ["Low", "Normal", "High", "Urgent"]},
               "summary":  {"type": "STRING"}},
             "required": ["category", "priority", "summary"]}}}')) as answer
from   dual;
