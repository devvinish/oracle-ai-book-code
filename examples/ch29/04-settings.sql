-- @setup drop table if exists ai_settings purge
create table ai_settings (
  name   varchar2(30)  constraint ai_settings_pk primary key,
  value  varchar2(100) not null
);
insert into ai_settings values ('AI_ENABLED', 'Yes');        -- the switch for every AI call
insert into ai_settings values ('DAILY_CALL_LIMIT', '2000');  -- calls per day, all models
commit;

-- GENERATE of Chapter 10, checking the switch and the limit before every call
create or replace function generate (
  p_prompt   in clob,
  p_model    in varchar2 default 'GEMINI',
  p_options  in json     default null
) return clob
is
  l_params    json;
  l_thinking  varchar2(3);
  l_response  clob;
  l_start     timestamp := systimestamp;
  l_attempt   pls_integer := 0;
  l_error     varchar2(4000);
  l_enabled   varchar2(100);
  l_limit     number;
  l_today     number;

  procedure log_call is
    pragma autonomous_transaction;
    l_elapsed interval day to second := systimestamp - l_start;
  begin
    insert into llm_calls (model, prompt, response, attempts, elapsed_ms, error)
    values (p_model, p_prompt, l_response, l_attempt,
            round((extract(minute from l_elapsed) * 60 + extract(second from l_elapsed))
                  * 1000), l_error);
    commit;
  end;
begin
  select max(case name when 'AI_ENABLED' then value end),
         to_number(max(case name when 'DAILY_CALL_LIMIT' then value end))
  into   l_enabled, l_limit
  from   ai_settings;
  if l_enabled = 'No' then
    raise_application_error(-20100, 'AI features are switched off');
  end if;
  select count(*) into l_today from llm_calls where called_at >= trunc(systimestamp);
  if l_today >= l_limit then
    raise_application_error(-20101,
      'The daily limit of ' || l_limit || ' AI calls is reached');
  end if;

  select case when p_options is null then params
              else json_mergepatch(params, p_options returning json) end,
         thinking
  into   l_params, l_thinking
  from   llm_models
  where  name = p_model;
  if l_thinking = 'No' then
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
