-- replaces e-mail addresses, card numbers, and phone numbers with placeholders
create or replace function redact (p_text in clob) return clob
is
  l_text clob := p_text;
begin
  l_text := regexp_replace(l_text,
              '[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}', '[e-mail]');
  l_text := regexp_replace(l_text,
              '\d{4}[ -]?\d{4}[ -]?\d{4}[ -]?\d{1,4}', '[card number]');
  l_text := regexp_replace(l_text,
              '\+?\d{1,3}[ .-]?\(?\d{2,4}\)?[ .-]?\d{3,4}[ .-]?\d{3,4}', '[phone]');
  return l_text;
end;
/

select redact('Please call me at +44 20 7946 0958 or write to '
              || 'olivia.walker@northwind.example. The charge was on card '
              || '4111 1111 1111 1111, on 3 March 2026.') as redacted
from   dual;
