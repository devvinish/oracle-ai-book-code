-- @setup begin execute immediate 'alter table ticket_archive drop column embedding'; exception when others then null; end;
alter table ticket_archive add (embedding vector(384, float32));

set timing on
update ticket_archive
set    embedding = vector_embedding(all_minilm_l12_v2
                     using subject || '. ' || description as data);
set timing off
commit;
