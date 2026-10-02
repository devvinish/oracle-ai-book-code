-- @setup drop table if exists llm_calls purge
create table llm_calls (
  call_id     number generated always as identity constraint llm_calls_pk primary key,
  called_at   timestamp default systimestamp not null,
  model       varchar2(30) not null,
  prompt      clob,
  response    clob,
  attempts    number,
  elapsed_ms  number,
  error       varchar2(4000)
);

create or replace function generate (
  p_prompt   in clob,
  p_model    in varchar2 default 'GEMINI',
  p_options  in json     default null
) return clob
is
  l_params    json;
  l_response  clob;
  l_start     timestamp := systimestamp;
  l_attempt   pls_integer := 0;
  l_error     varchar2(4000);
  l_thinking  varchar2(3);

  procedure log_call is
    pragma autonomous_transaction;       -- the log is kept even if the caller rolls back
    l_elapsed interval day to second := systimestamp - l_start;
  begin
    insert into llm_calls (model, prompt, response, attempts, elapsed_ms, error)
    values (p_model, p_prompt, l_response, l_attempt,
            round((extract(minute from l_elapsed) * 60 + extract(second from l_elapsed))
                  * 1000), l_error);
    commit;
  end;
begin
  select case when p_options is null then params
              else json_mergepatch(params, p_options returning json) end,
         thinking
  into   l_params, l_thinking
  from   llm_models
  where  name = p_model;
  if l_thinking = 'No' then          -- a model without thinking rejects thinking settings
    select json_transform(l_params, remove '$.generationConfig.thinkingConfig')
    into   l_params
    from   dual;
  end if;

  loop
    l_attempt := l_attempt + 1;
    begin
      l_response := dbms_vector_chain.utl_to_generate_text(p_prompt, l_params);
      l_error := null;
      exit;
    exception
      when others then
        l_error := substr(sqlerrm, 1, 4000);
        -- busy or over the rate limit: wait and try again, at most 3 times
        if l_attempt < 3
           and regexp_like(l_error, 'high demand|unavailable|429|RESOURCE_EXHAUSTED|503',
                           'i') then
          dbms_session.sleep(2 * l_attempt);
        else
          log_call;
          raise;
        end if;
    end;
  end loop;
  log_call;
  return l_response;
end;
/

select generate('Name the smallest planet of the solar system. Answer with one word.')
         as answer
from   dual;

select model, attempts, elapsed_ms, substr(prompt, 1, 40) || '...' as prompt,
       substr(response, 1, 20) as response
from   llm_calls
order  by call_id;
