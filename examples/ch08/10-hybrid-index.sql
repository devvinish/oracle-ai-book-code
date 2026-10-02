-- @setup drop index if exists kb_articles_hybrid force
drop index kb_articles_text;

set timing on
create hybrid vector index kb_articles_hybrid on kb_articles (body)
  parameters ('model ALL_MINILM_L12_V2 vector_idxtype ivf');
set timing off

select index_name, index_type, ityp_owner || '.' || ityp_name as indextype
from   user_indexes
where  index_name = 'KB_ARTICLES_HYBRID';
