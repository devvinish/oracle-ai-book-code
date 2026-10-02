-- text, chunks, and embeddings with the functions of DBMS_VECTOR_CHAIN, for one document
select json_value(e.column_value, '$.embed_id') as chunk_id,
       regexp_replace(substr(json_value(e.column_value, '$.embed_data'), 1, 40), '\s+', ' ')
         || '...' as chunk_start,
       substr(json_value(e.column_value, '$.embed_vector' returning clob), 1, 30) || '...'
         as embedding
from   atlas_documents d,
       dbms_vector_chain.utl_to_embeddings(
         dbms_vector_chain.utl_to_chunks(
           dbms_vector_chain.utl_to_text(d.content),
           json('{"by": "words", "max": 100, "split": "sentence", "normalize": "all"}')),
         json('{"provider": "database", "model": "ALL_MINILM_L12_V2"}')) e
where  d.file_name = 'atlas-sync-faq.docx';
