-- @setup drop table if exists ai_actions purge
-- every change an AI agent makes, with who approved it
create table ai_actions (
  action_id  number generated always as identity constraint ai_actions_pk primary key,
  done_at    timestamp default systimestamp not null,
  done_by    varchar2(255) not null,
  ticket_id  number not null,
  action     varchar2(30) not null,
  old_value  varchar2(100),
  new_value  varchar2(100)
);
