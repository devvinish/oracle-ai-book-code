-- the classifier where it is sure, the language model where it is not
with e as (
  select n, text, category,
         vector_embedding(all_minilm_l12_v2 using text as data) as embedding
  from   new_tickets),
scored as (
  select n, text, category,
         prediction(category_svm using embedding) as classifier,
         prediction_probability(category_svm using embedding) as probability
  from   e)
select n, category,
       case when probability >= 0.52 then classifier
            else llm_category(text) end as answer,
       case when probability >= 0.52 then 'classifier'
            else 'language model' end as decided_by
from   scored
order  by n;
