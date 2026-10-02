-- @setup drop table if exists ad_points purge
-- @setup drop table if exists ad_questions purge
-- every question asked of the data, with the generated SQL, the rows, and a sentence
create table ad_questions (
  question_id  number generated always as identity constraint ad_questions_pk primary key,
  asked_by     varchar2(255) not null,
  asked_at     timestamp default systimestamp not null,
  question     varchar2(1000) not null,
  sql_text     clob,
  result       json,
  row_count    number,
  error        varchar2(4000),
  answer       varchar2(2000)
);

-- the rows of an answer that a chart can show: a label and a number
create table ad_points (
  question_id  number not null constraint ad_points_question references ad_questions,
  seq          number not null,
  label        varchar2(200),
  value        number,
  constraint ad_points_pk primary key (question_id, seq)
);
