-- @setup drop index if exists ticket_archive_hnsw
-- the IVF index of the same column goes first: one vector index per column and metric
drop index ticket_archive_ivf;

set timing on
create vector index ticket_archive_hnsw on ticket_archive (embedding)
  organization inmemory neighbor graph
  distance cosine
  with target accuracy 95;
set timing off

select index_name, index_type, index_subtype, status
from   user_indexes
where  index_name = 'TICKET_ARCHIVE_HNSW';
