-- @setup drop table if exists doc_chunks purge
create table doc_chunks (
  doc_id        number         not null constraint doc_chunks_doc_fk
                                 references atlas_documents on delete cascade,
  chunk_id      number         not null,
  chunk_offset  number         not null,
  chunk_length  number         not null,
  chunk_text    varchar2(4000) not null,
  embedding     vector(384, float32),
  constraint doc_chunks_pk primary key (doc_id, chunk_id)
);

set timing on
insert into doc_chunks (doc_id, chunk_id, chunk_offset, chunk_length, chunk_text, embedding)
select d.doc_id,
       row_number() over (partition by d.doc_id order by c.chunk_offset),
       c.chunk_offset, c.chunk_length, c.chunk_text,
       vector_embedding(all_minilm_l12_v2 using c.chunk_text as data)
from   atlas_documents d,
       vector_chunks(dbms_vector_chain.utl_to_text(d.content)
                     by words max 100 split by sentence normalize all) c;
set timing off
commit;

select d.title, count(*) as chunks, round(avg(c.chunk_length)) as avg_characters
from   atlas_documents d join doc_chunks c on c.doc_id = d.doc_id
group  by d.doc_id, d.title
order  by d.doc_id;
