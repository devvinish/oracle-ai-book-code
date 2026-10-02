declare
  l_response clob;
begin
  dbms_vector.index_vector_memory_advisor(
    table_owner   => user,
    table_name    => 'TICKET_ARCHIVE',
    column_name   => 'EMBEDDING',
    index_type    => 'HNSW',
    response_json => l_response);
  dbms_output.put_line(l_response);
end;
/
