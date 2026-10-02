with questions (question) as (
  values ('The app shuts down as soon as I open it'),
         ('How do I get a copy of last month''s bill?'),
         ('Someone signed in from another country'))
select q.question, a.article_id || ' ' || a.title as nearest_article
from   questions q
cross  apply (select article_id, title
              from   kb_articles
              order  by vector_distance(embedding,
                          vector_embedding(all_minilm_l12_v2 using q.question as data),
                          cosine)
              fetch  first 1 row only) a;
