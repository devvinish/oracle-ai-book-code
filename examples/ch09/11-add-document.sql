-- @setup delete from atlas_documents where file_name = 'atlas-crm-8.4.1-release-notes.html'
create or replace function add_document (
  p_file_name   in varchar2,
  p_doc_type    in varchar2,
  p_title       in varchar2,
  p_product_id  in number,
  p_content     in blob
) return number
is
  l_doc_id number;
begin
  insert into atlas_documents (file_name, doc_type, title, product_id, content)
  values (p_file_name, p_doc_type, p_title, p_product_id, p_content)
  returning doc_id into l_doc_id;

  insert into doc_chunks (doc_id, chunk_id, chunk_offset, chunk_length, chunk_text,
                          embedding)
  select l_doc_id,
         row_number() over (order by c.chunk_offset),
         c.chunk_offset, c.chunk_length, c.chunk_text,
         vector_embedding(all_minilm_l12_v2 using c.chunk_text as data)
  from   vector_chunks(dbms_vector_chain.utl_to_text(p_content)
                       by words max 100 split by sentence normalize all) c;

  return l_doc_id;
end;
/

declare
  l_doc_id number;
begin
  l_doc_id := add_document(
    p_file_name  => 'atlas-crm-8.4.1-release-notes.html',
    p_doc_type   => 'Release notes',
    p_title      => 'Atlas CRM 8.4.1',
    p_product_id => 1,
    p_content    => to_blob(bfilename('ATLAS_FILES',
                                      'atlas-crm-8.4.1-release-notes.html')));
  commit;
  dbms_output.put_line('Document ' || l_doc_id || ' added');
end;
/

select d.doc_id, d.title, count(c.chunk_id) as chunks
from   atlas_documents d left join doc_chunks c on c.doc_id = d.doc_id
where  d.file_name = 'atlas-crm-8.4.1-release-notes.html'
group  by d.doc_id, d.title;
