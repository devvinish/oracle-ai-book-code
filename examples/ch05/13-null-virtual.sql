-- @expect-error
-- @cleanup drop table if exists ticket_drafts purge
select nvl2(vector_embedding(all_minilm_l12_v2 using null as data), 'a vector', 'null')
       as embedding_of_null
from   dual;

create table ticket_drafts (
  text       varchar2(4000),
  embedding  vector generated always as
               (vector_embedding(all_minilm_l12_v2 using text as data)) virtual);
