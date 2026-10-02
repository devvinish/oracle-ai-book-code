-- reciprocal rank fusion: each method adds 1 / (60 + rank) for every article it finds
with semantic as (
  select q.question_id, a.article_id,
         rank() over (partition by q.question_id
                      order by vector_distance(a.embedding, q.minilm, cosine)) as rnk
  from   eval_questions q cross join kb_articles a
  where  q.lang = 'en'),
keyword as (
  select q.question_id, a.article_id,
         rank() over (partition by q.question_id order by score(1) desc) as rnk
  from   eval_questions q join kb_articles a
         on contains(a.body, text_query(q.question), 1) > 0
  where  q.lang = 'en'),
fused as (
  select s.question_id, s.article_id, s.rnk as semantic_rank, k.rnk as keyword_rank,
         1 / (60 + s.rnk) + nvl(1 / (60 + k.rnk), 0) as rrf_score
  from   semantic s
  left   join keyword k on k.question_id = s.question_id and k.article_id = s.article_id),
ranked as (
  select f.*, rank() over (partition by question_id order by rrf_score desc) as hybrid_rank
  from   fused f),
right_ranks as (
  select r.semantic_rank, r.keyword_rank, r.hybrid_rank
  from   ranked r join eval_questions q
         on q.question_id = r.question_id and q.article_id = r.article_id)
select 'semantic' as method,
       count(case when semantic_rank = 1 then 1 end)  as first,
       count(case when semantic_rank <= 3 then 1 end) as in_top_3
from   right_ranks
union all
select 'keyword', count(case when keyword_rank = 1 then 1 end),
       count(case when keyword_rank <= 3 then 1 end)
from   right_ranks
union all
select 'hybrid (RRF)', count(case when hybrid_rank = 1 then 1 end),
       count(case when hybrid_rank <= 3 then 1 end)
from   right_ranks;
