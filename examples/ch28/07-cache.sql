-- @setup drop table if exists answer_cache purge
create table answer_cache (
  question   varchar2(4000) not null,
  embedding  vector(384, float32) not null,
  answer     clob not null,
  cached_at  date default sysdate not null
);

-- answers ASK, or reuses the answer of a cached question that is nearer than p_max_distance
create or replace function ask_cached (
  p_question      in varchar2,
  p_max_distance  in number default 0.12
) return clob
is
  l_vector  vector(384, float32);
  l_answer  clob;

  procedure cache_answer is
    pragma autonomous_transaction;
  begin
    insert into answer_cache (question, embedding, answer)
    values (p_question, l_vector, l_answer);
    commit;
  end;
begin
  select vector_embedding(all_minilm_l12_v2 using p_question as data)
  into   l_vector
  from   dual;

  begin
    select answer into l_answer
    from   answer_cache
    where  vector_distance(embedding, l_vector) <= p_max_distance
    order  by vector_distance(embedding, l_vector)
    fetch  first 1 row only;
  exception
    when no_data_found then              -- nothing near enough: ask, and cache the answer
      l_answer := ask(p_question);
      cache_answer;
  end;
  return l_answer;
end;
/

-- the first question is answered and cached
select ask_cached('How many custom roles can an Enterprise account have?') as answer
from   dual;

-- two more questions: how near is the cached one, and would a cutoff reuse its answer?
with q (question) as (
  values ('What is the maximum number of custom roles on Enterprise?'),
         ('How many users can an Enterprise account have?'))
select q.question,
       round(min(vector_distance(c.embedding,
             vector_embedding(all_minilm_l12_v2 using q.question as data))), 3) as distance,
       case when min(vector_distance(c.embedding,
             vector_embedding(all_minilm_l12_v2 using q.question as data))) <= 0.12
            then 'reused' else 'asked' end as at_0_12,
       case when min(vector_distance(c.embedding,
             vector_embedding(all_minilm_l12_v2 using q.question as data))) <= 0.25
            then 'reused' else 'asked' end as at_0_25
from   q cross join answer_cache c
group  by q.question;
