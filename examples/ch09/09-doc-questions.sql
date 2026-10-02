-- @setup drop table if exists doc_questions purge
-- questions answered only by the documents, each with words the right chunk must contain
create table doc_questions (
  question_id  number        constraint doc_questions_pk primary key,
  question     varchar2(200) not null,
  answer_text  varchar2(100) not null
);

insert into doc_questions values
  ( 1, 'How many custom roles can an Enterprise account have?',   'up to 20 per account'),
  ( 2, 'How long is an invitation link valid?',                  'valid for 7 days'),
  ( 3, 'What is the largest file the contact importer accepts?', '20 MB'),
  ( 4, 'How long is the audit log kept on Professional?',        '180 days'),
  ( 5, 'When does Billing retry a failed payment?',              '3 days later'),
  ( 6, 'How long does a refund of a direct debit take?',         'up to 3 business days'),
  ( 7, 'What does a yearly subscription cost?',                  'price of ten months'),
  ( 8, 'Which Android version does the mobile app need?',        'Android 11'),
  ( 9, 'How often does the app sync in the background?',         'every 15 minutes'),
  (10, 'How many records does one page of the API return?',     '100 records per page'),
  (11, 'Until when is API version v3 supported?',                '30 June 2027'),
  (12, 'What is the largest file Atlas Sync can upload?',        '5 GB'),
  (13, 'When was Atlas CRM 8.4.1 released?',                     '14 September 2026'),
  (14, 'How much smaller are offline downloads in 3.9.1?',       '40 percent');
commit;

-- is the answer in one of the 3 chunks nearest to the question?
select count(*) as questions,
       count(case when exists (
               select 1
               from  (select c.chunk_text
                      from   doc_chunks c
                      order  by vector_distance(c.embedding,
                                  vector_embedding(all_minilm_l12_v2
                                    using q.question as data), cosine)
                      fetch  first 3 rows only) top3
               where  instr(top3.chunk_text, q.answer_text) > 0) then 1 end)
         as answer_in_top_3
from   doc_questions q;
