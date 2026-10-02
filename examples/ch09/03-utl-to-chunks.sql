select json_value(c.column_value, '$.chunk_id')     as id,
       json_value(c.column_value, '$.chunk_offset') as offset,
       json_value(c.column_value, '$.chunk_length') as length,
       regexp_replace(substr(json_value(c.column_value, '$.chunk_data'), 1, 60), '\s+', ' ')
         || '...' as chunk_start
from   atlas_documents d,
       dbms_vector_chain.utl_to_chunks(
         dbms_vector_chain.utl_to_text(d.content),
         json('{"by": "words", "max": 100, "split": "sentence", "normalize": "all"}')) c
where  d.file_name = 'atlas-mobile-guide.pdf';
