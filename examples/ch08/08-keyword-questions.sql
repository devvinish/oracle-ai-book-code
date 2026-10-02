-- @setup delete from eval_questions where question_id > 28
-- questions that name exact things: codes, versions, products of other companies
insert into eval_questions (question_id, question, article_id) values
  (29, 'Where do we enter our GSTIN?',            'KB-203'),
  (30, 'Can we roll it out with Intune?',         'KB-702'),
  (31, 'What does the Retry-After header mean?',  'KB-602'),
  (32, 'Is 8.4.1 released yet?',                  'KB-301'),
  (33, 'Defender keeps holding our mails',        'KB-102'),
  (34, 'Does 3.9.1 fix it?',                      'KB-401'),
  (35, 'Our MSI install fails',                   'KB-702'),
  (36, 'What is a weighted forecast?',            'KB-303');

update eval_questions
set    minilm = vector_embedding(all_minilm_l12_v2 using question as data)
where  question_id > 28;
commit;

-- the rank of the right article by meaning and by words
with semantic as (
  select q.question_id, a.article_id,
         rank() over (partition by q.question_id
                      order by vector_distance(a.embedding, q.minilm, cosine)) as rnk
  from   eval_questions q cross join kb_articles a
  where  q.question_id > 28),
keyword as (
  select q.question_id, a.article_id,
         rank() over (partition by q.question_id order by score(1) desc) as rnk
  from   eval_questions q join kb_articles a
         on contains(a.body, text_query(q.question), 1) > 0
  where  q.question_id > 28)
select q.question, s.rnk as semantic_rank, k.rnk as keyword_rank
from   eval_questions q
join   semantic s on s.question_id = q.question_id and s.article_id = q.article_id
left   join keyword k on k.question_id = q.question_id and k.article_id = q.article_id
where  q.question_id > 28
order  by q.question_id;
