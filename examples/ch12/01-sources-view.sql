-- @setup begin execute immediate 'alter table doc_chunks drop column gemini_embedding'; exception when others then null; end;
-- the document chunks get Gemini embeddings too, as the articles did in Chapter 6
alter table doc_chunks add (gemini_embedding vector(3072, float32));

declare
  l_chunks   sys.vector_array_t;
  l_results  sys.vector_array_t;
  l_params   json;
begin
  select params into l_params from embedding_models where name = 'GEMINI';

  select json_object('chunk_id' value doc_id * 1000 + chunk_id,
                     'chunk_data' value chunk_text returning clob)
  bulk   collect into l_chunks
  from   doc_chunks;

  l_results := dbms_vector_chain.utl_to_embeddings(l_chunks, l_params);

  forall i in 1 .. l_results.count
    update doc_chunks
    set    gemini_embedding = to_vector(json_value(l_results(i), '$.embed_vector'
                                                   returning clob))
    where  doc_id * 1000 + chunk_id = json_value(l_results(i), '$.embed_id');
  commit;
end;
/

-- everything the assistant may answer from: articles and document chunks
create or replace view knowledge as
select 'Article ' || a.article_id as source, a.body as text,
       a.embedding, a.gemini_embedding
from   kb_articles a
union all
select d.title || ', part ' || c.chunk_id, to_clob(c.chunk_text),
       c.embedding, c.gemini_embedding
from   doc_chunks c join atlas_documents d on d.doc_id = c.doc_id;

select count(*) as sources,
       count(case when gemini_embedding is not null then 1 end) as with_gemini
from   knowledge;
