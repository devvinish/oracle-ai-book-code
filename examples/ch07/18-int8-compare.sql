-- for the 28 questions: the 10 nearest tickets by FLOAT32 and by INT8 embeddings
with q as (
  select question_id, minilm as v,
         to_vector(minilm
                   * to_vector('[' || rtrim(rpad('400,', 1536, '400,'), ',') || ']'),
                   384, int8) as v8
  from   eval_questions
  where  question_id <= 28),
by_float as (
  select q.question_id, max(f.distance) as tenth
  from   q cross apply (select vector_distance(embedding, q.v, cosine) as distance
                        from   ticket_archive
                        order  by distance
                        fetch  exact first 10 rows only) f
  group  by q.question_id),
by_int8 as (
  select q.question_id, vector_distance(t.embedding, q.v, cosine) as float_distance
  from   q cross apply (select embedding
                        from   ticket_archive
                        order  by vector_distance(embedding_int8, q.v8, cosine)
                        fetch  exact first 10 rows only) t)
select count(*) as int8_results,
       sum(is_right) as right_results,
       round(100 * sum(is_right) / count(*)) as pct
from  (select case when i.float_distance <= f.tenth + 1e-6 then 1 else 0 end as is_right
       from   by_int8 i join by_float f on f.question_id = i.question_id);
