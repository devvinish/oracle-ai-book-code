with questions (question) as (
  values ('What is the capital of France?'),
         ('How do I bake sourdough bread?'),
         ('Who won the football world cup?'),
         ('Can I pay my invoice in Bitcoin?'))
select q.question,
       (select round(min(vector_distance(a.embedding,
                 vector_embedding(all_minilm_l12_v2 using q.question as data), cosine)), 3)
        from   kb_articles a) as nearest_article
from   questions q;
