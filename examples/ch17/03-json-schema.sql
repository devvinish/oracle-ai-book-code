-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
select apex_ai.generate(
         p_prompt               => 'Classify this ticket: "Our invoice shows the wrong VAT '
                                   || 'rate since we moved to Germany."',
         p_temperature          => 0,
         p_response_json_schema => '{
           "type": "object",
           "properties": {
             "category": {"type": "string",
                          "enum": ["Account", "Billing", "Bug", "Question",
                                   "Feature Request"]},
             "product":  {"type": "string"}},
           "required": ["category", "product"]}') as answer
from   dual;
