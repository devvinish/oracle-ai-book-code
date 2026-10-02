-- @setup drop table if exists embeddings_any purge
-- @cleanup drop table if exists embeddings_any purge
create table embeddings_any (
  id     number,
  model  varchar2(40),
  v      vector(*, *)          -- any number of dimensions, any format
);

insert into embeddings_any values (1, 'topic scores',  vector('[0.9, 0.05, 0.3]'));
insert into embeddings_any values (2, 'small model',   vector('[1, 2, 3, 4, 5]', 5, int8));
insert into embeddings_any values (3, 'another model', vector('[0.5, 0.25]', 2, float64));

select id, model, vector_dimension_count(v) as dims, vector_dimension_format(v) as format
from   embeddings_any;
