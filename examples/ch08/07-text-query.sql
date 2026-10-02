-- turns a question into an Oracle Text query: every word in braces, joined with ACCUM
create or replace function text_query (p_text in varchar2) return varchar2
deterministic
is
  l_words varchar2(4000);
begin
  l_words := regexp_replace(p_text, '[{}?!,;:"()]|\.$', '');   -- punctuation, not 8.4.1
  l_words := trim(regexp_replace(l_words, '\s+', ' '));
  return '{' || replace(l_words, ' ', '} accum {') || '}';
end;
/

select text_query('Is 8.4.1 released yet?') as text_query from dual;

select article_id, title, score(1) as score
from   kb_articles
where  contains(body, text_query('What does the Retry-After header mean?'), 1) > 0
order  by score desc;
