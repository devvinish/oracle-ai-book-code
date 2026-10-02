-- for each question and model: the rank of the right article among all 24
with ranks as (
  select q.question_id, q.lang, q.article_id, a.article_id as candidate,
         rank() over (partition by q.question_id
                      order by vector_distance(a.embedding, q.minilm, cosine))
           as minilm_rank,
         rank() over (partition by q.question_id
                      order by vector_distance(a.gemini_embedding, q.gemini, cosine))
           as gemini_rank
  from   eval_questions q cross join kb_articles a
)
select lang, count(*) as questions,
       count(case when minilm_rank = 1 then 1 end) as minilm_first,
       count(case when gemini_rank = 1 then 1 end) as gemini_first
from   ranks
where  candidate = article_id
group  by lang
order  by questions desc, lang;
