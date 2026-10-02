-- @setup drop table if exists ka_questions purge
-- every question asked in the knowledge assistant, with its answer and the user's feedback
create table ka_questions (
  question_id  number generated always as identity constraint ka_questions_pk primary key,
  asked_by     varchar2(255) not null,
  asked_at     timestamp default systimestamp not null,
  question     varchar2(1000) not null,
  answer       clob,
  sources      json,
  outcome      varchar2(10) not null constraint ka_questions_outcome
                 check (outcome in ('Answered', 'Not found', 'Off topic')),
  helpful      varchar2(1) constraint ka_questions_helpful check (helpful in ('Y', 'N')),
  embedding    vector(384, float32)
);
