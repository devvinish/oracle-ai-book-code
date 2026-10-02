-- @setup begin for c in (select column_name from user_tab_columns where table_name = 'TICKETS' and column_name like 'AI\_%' escape '\') loop execute immediate 'alter table tickets drop column ' || c.column_name; end loop; end;
alter table tickets add (
  ai_category   varchar2(20),
  ai_priority   varchar2(10),
  ai_sentiment  varchar2(10),
  ai_summary    varchar2(200),
  ai_done_at    timestamp
);
