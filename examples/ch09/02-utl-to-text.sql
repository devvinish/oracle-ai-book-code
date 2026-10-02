select doc_id, doc_type,
       length(dbms_vector_chain.utl_to_text(content)) as characters
from   atlas_documents
order  by doc_id;

select dbms_vector_chain.utl_to_text(content) as text
from   atlas_documents
where  file_name = 'atlas-mobile-3.9.1-release-notes.html';
