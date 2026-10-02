-- the 100 test tickets: the classifier and the model of Chapter 11, against the agents
set timing on
select count(*) as tickets,
       count(case when prediction(category_svm using m.embedding) = m.category then 1 end)
         as classifier_right,
       count(case when t.ai_category = m.category then 1 end) as llm_right
from   ml_tickets m join tickets t on t.ticket_id = m.ticket_id
where  m.data_set = 'Test';
set timing off

select ticket_id, category,
       prediction(category_svm using embedding) as predicted,
       round(prediction_probability(category_svm using embedding), 2) as probability
from   ml_tickets
where  data_set = 'Test'
order  by ticket_id
fetch  first 5 rows only;
