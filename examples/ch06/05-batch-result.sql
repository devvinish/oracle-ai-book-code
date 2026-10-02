declare
  l_results sys.vector_array_t;
begin
  l_results := dbms_vector_chain.utl_to_embeddings(
                 sys.vector_array_t('{"chunk_id": 1, "chunk_data": "I cannot sign in"}',
                                    '{"chunk_id": 2, "chunk_data": "Billed twice"}'),
                 json('{"provider": "database", "model": "ALL_MINILM_L12_V2"}'));
  dbms_output.put_line(substr(l_results(1), 1, 90) || '...');
end;
/
