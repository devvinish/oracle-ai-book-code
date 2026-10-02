-- @setup begin execute immediate 'alter table kb_articles drop column embedding'; exception when others then null; end;
alter table kb_articles add (embedding vector(384, float32));

update kb_articles
set    embedding = vector_embedding(all_minilm_l12_v2 using title || '. ' || body as data);
commit;

select count(*) as articles,
       count(case when embedding is not null then 1 end) as embedded
from   kb_articles;
