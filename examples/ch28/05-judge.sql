-- @setup drop table if exists judged_answers purge
-- 20 questions of Chapter 6: answers from ASK, graded against the right article
create table judged_answers as
select q.question_id, q.question, q.article_id,
       ask(q.question) as answer,
       cast(null as varchar2(10)) as correct,
       cast(null as varchar2(10)) as unsupported,
       cast(null as varchar2(400)) as reason
from   eval_questions q
where  q.lang = 'en' and q.question_id <= 20;

update judged_answers j
set   (correct, unsupported, reason) = (
         select json_value(v, '$.correct'), json_value(v, '$.unsupported'),
                json_value(v, '$.reason')
         from  (select generate(
                  'You grade the answers of a support assistant. Reference article: '
                  || (select body from kb_articles a where a.article_id = j.article_id)
                  || chr(10) || 'Question: ' || j.question
                  || chr(10) || 'Answer: ' || j.answer
                  || chr(10) || 'Is the answer correct according to the reference? '
                  || 'Does it state anything that the reference does not support?',
                  'GEMINI',
                  json('{"generationConfig": {"temperature": 0,
                         "responseMimeType": "application/json",
                         "responseSchema": {"type": "OBJECT",
                           "required": ["correct", "unsupported", "reason"],
                           "properties": {
                             "correct":     {"type": "STRING", "enum": ["yes", "no"]},
                             "unsupported": {"type": "STRING", "enum": ["yes", "no"]},
                             "reason":      {"type": "STRING"}}}}}')) as v
                from   dual));
commit;

select count(*) as answers,
       count(case when correct = 'yes' then 1 end) as correct,
       count(case when unsupported = 'yes' then 1 end) as with_unsupported_claims
from   judged_answers;
