-- 20 English questions: the distance of the right article and of the nearest wrong one
with d as (
  select q.question_id, q.article_id as right_id, a.article_id,
         vector_distance(a.embedding, q.minilm, cosine) as distance
  from   eval_questions q cross join kb_articles a
  where  q.lang = 'en' and q.question_id <= 20),
per_question as (
  select question_id,
         min(case when article_id = right_id  then distance end)
           as right_article,
         min(case when article_id <> right_id then distance end)
           as nearest_wrong
  from   d
  group  by question_id)
select 'right article' as distance_of,
       round(min(right_article), 3) as lowest, round(avg(right_article), 3) as average,
       round(max(right_article), 3) as highest
from   per_question
union all
select 'nearest wrong article',
       round(min(nearest_wrong), 3), round(avg(nearest_wrong), 3),
       round(max(nearest_wrong), 3)
from   per_question;
