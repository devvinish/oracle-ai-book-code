-- the first two chunks of the guide, with an overlap of 20 words, split by sentence and not
with d as (select dbms_vector_chain.utl_to_text(content) as text
           from   atlas_documents
           where  file_name = 'atlas-mobile-guide.pdf')
select 'sentence' as split, c.chunk_offset, c.chunk_length,
       regexp_replace(substr(c.chunk_text, 1, 40), '\s+', ' ') || '...' as chunk_start
from   d, vector_chunks(d.text by words max 100 overlap 20 split by sentence) c
where  c.chunk_offset < 900
union all
select 'none', c.chunk_offset, c.chunk_length,
       regexp_replace(substr(c.chunk_text, 1, 40), '\s+', ' ') || '...'
from   d, vector_chunks(d.text by words max 100 overlap 20 split by none) c
where  c.chunk_offset < 900;
