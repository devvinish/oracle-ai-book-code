create or replace function generate (
  p_prompt   in clob,
  p_model    in varchar2 default 'GEMINI',
  p_options  in json     default null       -- provider options, merged into the parameters
) return clob
is
  l_params json;
begin
  select case when p_options is null then params
              else json_mergepatch(params, p_options returning json) end
  into   l_params
  from   llm_models
  where  name = p_model;
  return dbms_vector_chain.utl_to_generate_text(p_prompt, l_params);
end;
/

set timing on
select generate('Name the largest planet of the solar system. Answer with one word.')
         as gemini
from   dual;

select generate('Name the largest planet of the solar system. Answer with one word.',
                'GEMINI_LITE') as gemini_lite
from   dual;
set timing off
