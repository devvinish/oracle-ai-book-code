-- where the model and the agents disagree on the category
select category as agent_category, ai_category, count(*) as tickets
from   tickets
where  ai_category <> category
group  by category, ai_category
order  by tickets desc;
