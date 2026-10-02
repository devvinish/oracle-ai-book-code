select c.chunk_offset, c.chunk_length,
       regexp_replace(substr(c.chunk_text, 1, 60), '\s+', ' ') || '...' as chunk_start
from   (select dbms_vector_chain.utl_to_text(content) as text
        from   atlas_documents
        where  file_name = 'atlas-mobile-guide.pdf') d,
       vector_chunks(d.text by words max 100 split by sentence normalize all) c;
