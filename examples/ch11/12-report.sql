-- the stored results are ordinary columns: negative tickets per product, from the model
select p.name as product, count(*) as tickets,
       count(case when t.ai_sentiment = 'Negative' then 1 end) as negative,
       round(100 * count(case when t.ai_sentiment = 'Negative' then 1 end) / count(*))
         as negative_pct
from   tickets t join products p on p.product_id = t.product_id
group  by p.name
order  by negative_pct desc;
