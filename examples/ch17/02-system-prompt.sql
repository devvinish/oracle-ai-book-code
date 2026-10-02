-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
select apex_ai.generate(
         p_prompt        => 'Can I get my money back for a duplicate charge?',
         p_system_prompt => 'You are the support assistant of Atlas Software. '
                            || 'Answer in one sentence of plain text. '
                            || 'Refunds of duplicate charges are made '
                            || 'by support as soon as they are reported.',
         p_temperature   => 0) as answer
from   dual;
