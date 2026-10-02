-- how fast each model answers: the median and the slowest 5 percent of calls
select model, count(*) as calls,
       percentile_cont(0.5) within group (order by elapsed_ms) as median_ms,
       percentile_cont(0.95) within group (order by elapsed_ms) as p95_ms,
       count(case when error is not null then 1 end) as failed,
       count(case when attempts > 1 then 1 end) as retried
from   llm_calls
group  by model
order  by calls desc;
