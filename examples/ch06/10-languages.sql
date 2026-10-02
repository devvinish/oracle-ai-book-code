with ranks as (
  select q.question_id, q.lang, q.question, q.article_id, a.article_id as candidate,
         rank() over (partition by q.question_id
                      order by vector_distance(a.embedding, q.minilm, cosine))
           as minilm_rank,
         rank() over (partition by q.question_id
                      order by vector_distance(a.gemini_embedding, q.gemini, cosine))
           as gemini_rank
  from   eval_questions q cross join kb_articles a
)
select lang, question, minilm_rank, gemini_rank
from   ranks
where  candidate = article_id
and    lang <> 'en'
order  by question_id;
