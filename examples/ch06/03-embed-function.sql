create or replace function embed (
  p_text   in clob,
  p_model  in varchar2 default 'MINILM'
) return vector
is
  l_params json;
begin
  select params into l_params from embedding_models where name = p_model;
  return dbms_vector_chain.utl_to_embedding(p_text, l_params);
end;
/

select vector_dimension_count(embed('I cannot sign in'))           as minilm,
       vector_dimension_count(embed('I cannot sign in', 'GEMINI')) as gemini
from   dual;
