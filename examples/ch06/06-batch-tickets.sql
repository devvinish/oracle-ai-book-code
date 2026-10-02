-- @setup begin execute immediate 'alter table tickets drop column gemini_embedding'; exception when others then null; end;
alter table tickets add (gemini_embedding vector(3072, float32));

set timing on
declare
  l_chunks   sys.vector_array_t;
  l_results  sys.vector_array_t;
  l_params   json;
begin
  select params into l_params from embedding_models where name = 'GEMINI';

  -- one JSON object per ticket: its ID and its text
  select json_object('chunk_id'   value ticket_id,
                     'chunk_data' value subject || '. ' || description
                     returning clob)
  bulk   collect into l_chunks
  from   tickets;

  l_results := dbms_vector_chain.utl_to_embeddings(l_chunks, l_params);

  -- each result says which ticket it belongs to
  forall i in 1 .. l_results.count
    update tickets
    set    gemini_embedding = to_vector(json_value(l_results(i), '$.embed_vector'
                                                   returning clob))
    where  ticket_id = json_value(l_results(i), '$.embed_id');

  dbms_output.put_line('Tickets embedded: ' || l_results.count);
end;
/
set timing off
commit;
