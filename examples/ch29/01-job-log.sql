-- @setup drop table if exists ai_job_log purge
create table ai_job_log (
  logged_at  timestamp default systimestamp not null,
  task       varchar2(30)  not null,
  status     varchar2(10)  not null,      -- Done or Failed
  done       number,
  message    varchar2(4000)
);

create or replace procedure log_job (
  p_task in varchar2, p_status in varchar2, p_done in number default null,
  p_message in varchar2 default null)
is
  pragma autonomous_transaction;
begin
  insert into ai_job_log (task, status, done, message)
  values (p_task, p_status, p_done, substr(p_message, 1, 4000));
  commit;
end;
/

-- EMBED_PENDING of Chapter 6, with its failures in the log instead of printed
create or replace procedure embed_pending (p_batch_size in pls_integer default 100)
is
  l_chunks   sys.vector_array_t;
  l_results  sys.vector_array_t;
  l_params   json;
  l_done     pls_integer := 0;
begin
  select params into l_params from embedding_models where name = 'GEMINI';
  loop
    select json_object('chunk_id'   value ticket_id,
                       'chunk_data' value subject || '. ' || description
                       returning clob)
    bulk   collect into l_chunks
    from   tickets
    where  gemini_embedding is null
    fetch  first p_batch_size rows only;
    exit when l_chunks.count = 0;

    l_results := dbms_vector_chain.utl_to_embeddings(l_chunks, l_params);
    forall i in 1 .. l_results.count
      update tickets
      set    gemini_embedding = to_vector(json_value(l_results(i), '$.embed_vector'
                                                     returning clob))
      where  ticket_id = json_value(l_results(i), '$.embed_id');
    l_done := l_done + l_results.count;
    commit;
  end loop;
  if l_done > 0 then log_job('EMBED_PENDING', 'Done', l_done); end if;
exception
  when others then
    rollback;
    log_job('EMBED_PENDING', 'Failed', l_done, sqlerrm);   -- the next run tries again
end;
/
