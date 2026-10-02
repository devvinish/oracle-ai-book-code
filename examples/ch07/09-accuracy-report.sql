declare
  l_query_vector vector;
begin
  select vector_embedding(all_minilm_l12_v2
           using 'The invoice was paid two times by mistake' as data)
  into   l_query_vector
  from   dual;

  dbms_output.put_line(dbms_vector.index_accuracy_query(
    owner_name      => user,
    index_name      => 'TICKET_ARCHIVE_IVF',
    qv              => l_query_vector,
    top_k           => 10,
    target_accuracy => 90));
end;
/
