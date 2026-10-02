-- @setup delete from tickets where ticket_id = 9002
-- @cleanup delete from tickets where ticket_id = 9002
create or replace procedure embed_pending (p_batch_size in pls_integer default 100)
is
  l_chunks   sys.vector_array_t;
  l_results  sys.vector_array_t;
  l_params   json;
begin
  select params into l_params from embedding_models where name = 'GEMINI';

  loop
    -- the next batch of tickets that have no Gemini embedding yet
    select json_object('chunk_id'   value ticket_id,
                       'chunk_data' value subject || '. ' || description
                       returning clob)
    bulk   collect into l_chunks
    from   tickets
    where  gemini_embedding is null
    fetch  first p_batch_size rows only;

    exit when l_chunks.count = 0;

    begin
      l_results := dbms_vector_chain.utl_to_embeddings(l_chunks, l_params);
    exception
      when others then
        -- leave the rows for the next run: the provider may be busy or down
        dbms_output.put_line('Gemini failed, will retry later: '
                             || substr(sqlerrm, 1, 60));
        exit;
    end;

    forall i in 1 .. l_results.count
      update tickets
      set    gemini_embedding = to_vector(json_value(l_results(i), '$.embed_vector'
                                                     returning clob))
      where  ticket_id = json_value(l_results(i), '$.embed_id');

    dbms_output.put_line('Tickets embedded: ' || l_results.count);
    commit;
  end loop;
end;
/

insert into tickets (ticket_id, customer_id, product_id, subject, description,
                     priority, status, category, channel, created_at)
values (9002, 1, 2, 'Refund for a double payment',
        'We paid invoice 1043 twice by mistake. Please refund one of the payments.',
        'Normal', 'Open', 'Billing', 'Portal', systimestamp);
commit;

exec embed_pending

select ticket_id,
       vector_dimension_count(embedding)        as minilm,
       vector_dimension_count(gemini_embedding) as gemini
from   tickets
where  ticket_id = 9002;

exec embed_pending
