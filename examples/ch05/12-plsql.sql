-- @expect-error
declare
  v vector;
begin
  v := vector_embedding(all_minilm_l12_v2 using 'I cannot sign in' as data);
end;
/

create or replace function embed (p_text in clob) return vector
is
  v vector(384, float32);
begin
  select vector_embedding(all_minilm_l12_v2 using p_text as data) into v from dual;
  return v;
end;
/

select article_id, title
from   kb_articles
order  by vector_distance(embedding, embed('My invoice was charged two times'), cosine)
fetch  first 2 rows only;
