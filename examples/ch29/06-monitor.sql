-- one row per day: what the AI features did, for a dashboard
create or replace view ai_daily_stats as
select trunc(called_at) as day, model, count(*) as calls,
       count(case when error is not null then 1 end) as failed,
       round(avg(elapsed_ms)) as avg_ms,
       round(sum(dbms_lob.getlength(prompt)) / 1024) as prompt_kb
from   llm_calls
group  by trunc(called_at), model;

select * from ai_daily_stats order by day desc, calls desc;
