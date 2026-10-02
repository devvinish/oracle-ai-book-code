select count(*) as tickets,
       count(case when ai_category = category then 1 end) as same_category,
       round(100 * count(case when ai_category = category then 1 end) / count(*))
         as category_pct,
       count(case when ai_priority = priority then 1 end) as same_priority,
       round(100 * count(case when ai_priority = priority then 1 end) / count(*))
         as priority_pct
from   tickets;
