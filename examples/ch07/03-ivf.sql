-- @setup drop index if exists ticket_archive_hnsw
-- @setup drop index if exists ticket_archive_ivf
set timing on
create vector index ticket_archive_ivf on ticket_archive (embedding)
  organization neighbor partitions
  distance cosine
  with target accuracy 95;
set timing off
