-- @keep-output
-- the last four calls to Gemini: three from SQL Commands with Gemini, one with Gemini Lite
select to_char(request_date, 'HH24:MI:SS') as at,
       regexp_substr(url, 'models/([^:]+)', 1, 1, null, 1) as model,
       round(elapsed_sec, 1) as seconds,
       ai_tokens_consumed as tokens
from   apex_webservice_log
where  request_date > sysdate - 1/24
and    url like '%generativelanguage%'
order  by request_date desc
fetch  first 4 rows only;
