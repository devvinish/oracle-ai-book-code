-- @setup drop table if exists chunk_trials purge
-- @cleanup drop table if exists chunk_trials purge
create table chunk_trials (
  max_words   number,
  chunk_text  varchar2(4000),
  embedding   vector(384, float32)
);

-- the documents chunked five ways: at most 30, 50, 100, 200, and 400 words per chunk
insert into chunk_trials
select s.max_words, json_value(c.column_value, '$.chunk_data'),
       vector_embedding(all_minilm_l12_v2
                        using json_value(c.column_value, '$.chunk_data') as data)
from   atlas_documents d,
       (values (30), (50), (100), (200), (400)) s (max_words),
       dbms_vector_chain.utl_to_chunks(
         dbms_vector_chain.utl_to_text(d.content),
         json_object('by' value 'words', 'max' value s.max_words,
                     'split' value 'sentence', 'normalize' value 'all' returning json)) c;
commit;

with q as (
  select question_id, answer_text,
         vector_embedding(all_minilm_l12_v2 using question as data) as v
  from   doc_questions),
ranked as (
  select t.max_words, q.question_id, q.answer_text, t.chunk_text,
         row_number() over (partition by t.max_words, q.question_id
                            order by vector_distance(t.embedding, q.v, cosine)) as rn
  from   chunk_trials t cross join q)
select max_words,
       count(distinct case when rn = 1 and instr(chunk_text, answer_text) > 0
                           then question_id end) as answer_first,
       count(distinct case when rn <= 3 and instr(chunk_text, answer_text) > 0
                           then question_id end) as answer_in_top_3,
       round(avg(case when rn <= 3 then length(chunk_text) end) * 3) as characters_in_top_3
from   ranked
group  by max_words
order  by max_words;
