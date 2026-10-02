-- @setup drop table if exists hd_replies purge
-- every reply drafted by the model, and what the agent sent
create table hd_replies (
  reply_id    number generated always as identity constraint hd_replies_pk primary key,
  ticket_id   number not null constraint hd_replies_ticket references tickets,
  agent       varchar2(255) not null,
  drafted_at  timestamp default systimestamp not null,
  draft       clob not null,
  sent_at     timestamp,
  sent        clob,
  similarity  number   -- how much of the draft the agent kept, 0 to 100
);
