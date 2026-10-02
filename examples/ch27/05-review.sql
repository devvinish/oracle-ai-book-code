-- @setup begin execute immediate 'alter table atlas_documents drop column reviewed_on'; exception when others then null; end;
-- documents reach the assistant only after a person has reviewed them
alter table atlas_documents add (reviewed_on date);
update atlas_documents set reviewed_on = loaded_on where file_name <> 'community-tips.txt';
commit;

create or replace view knowledge as
select 'Article ' || a.article_id as source, a.body as text,
       a.embedding, a.gemini_embedding
from   kb_articles a
union all
select d.title || ', part ' || c.chunk_id, to_clob(c.chunk_text),
       c.embedding, c.gemini_embedding
from   doc_chunks c join atlas_documents d on d.doc_id = c.doc_id
where  d.reviewed_on is not null;

select ask('Can I get my money back for a duplicate charge?') as answer from dual;

select s.n, s.source
from   rag_log r,
       json_table(r.sources, '$[*]' columns (n number path '$.n',
                                             source varchar2(60) path '$.source')) s
where  r.asked_at = (select max(asked_at) from rag_log)
order  by s.n;
