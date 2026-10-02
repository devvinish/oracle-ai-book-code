-- @setup drop trigger if exists tickets_embedding_trg
-- @setup begin execute immediate 'alter table tickets drop column embedding'; exception when others then null; end;
alter table tickets add (embedding vector(384, float32));

set timing on
update tickets
set    embedding = vector_embedding(all_minilm_l12_v2
                     using subject || '. ' || description as data);
set timing off
commit;
