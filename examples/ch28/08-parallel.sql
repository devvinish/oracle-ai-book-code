-- @setup drop table if exists embed_test purge
-- @cleanup drop table if exists embed_test purge
create table embed_test as
select archive_id, subject, description from ticket_archive where archive_id <= 2000;
alter table embed_test add (embedding vector(384, float32));

set timing on
update embed_test
set    embedding = vector_embedding(all_minilm_l12_v2
                     using subject || '. ' || description as data);
commit;

update embed_test set embedding = null;
commit;

alter session enable parallel dml;
update /*+ parallel(embed_test 2) */ embed_test
set    embedding = vector_embedding(all_minilm_l12_v2
                     using subject || '. ' || description as data);
commit;
set timing off

-- the plan of the parallel update: does it have parallel operations?
explain plan for
update /*+ parallel(embed_test 2) */ embed_test
set    embedding = vector_embedding(all_minilm_l12_v2
                     using subject || '. ' || description as data);

select lpad(' ', 2 * depth) || operation || ' ' || options as operation, object_name
from   plan_table
order  by id;
