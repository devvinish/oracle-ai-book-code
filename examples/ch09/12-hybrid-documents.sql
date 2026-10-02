-- @setup drop index if exists atlas_documents_hybrid force
set timing on
create hybrid vector index atlas_documents_hybrid on atlas_documents (content)
  parameters ('model ALL_MINILM_L12_V2 vector_idxtype ivf');
set timing off

select d.title,
       regexp_replace(substr(r.chunk_text, 1, 60), '\s+', ' ') || '...' as chunk_start
from   json_table(
         dbms_hybrid_vector.search(json('{
           "hybrid_index_name": "ATLAS_DOCUMENTS_HYBRID",
           "search_text": "Until when is API version v3 supported?",
           "return": {"topN": 3, "values": ["rowid", "chunk_text"]}}')),
         '$[*]' columns (row_id     varchar2(18)   path '$.rowid',
                         chunk_text varchar2(4000) path '$.chunk_text')) r
join   atlas_documents d on d.rowid = chartorowid(r.row_id);
