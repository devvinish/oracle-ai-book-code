-- @setup begin execute immediate 'alter table kb_articles drop column gemini_embedding'; exception when others then null; end;
alter table kb_articles add (gemini_embedding vector(3072, float32));

set timing on
update kb_articles
set    gemini_embedding = embed(title || '. ' || body, 'GEMINI');
set timing off
commit;
