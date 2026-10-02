-- @setup begin dbms_scheduler.drop_job('ATLAS_AI_JOBS', force => true); exception when others then null; end;
-- the background work of Atlas Support: embed and classify new tickets
create or replace procedure run_ai_jobs
is
  l_before  pls_integer;
  l_after   pls_integer;
begin
  embed_pending;

  select count(*) into l_before from tickets where ai_done_at is null;
  if l_before > 0 then
    begin
      classify_tickets;
      select count(*) into l_after from tickets where ai_done_at is null;
      log_job('CLASSIFY_TICKETS', 'Done', l_before - l_after);
    exception
      when others then
        log_job('CLASSIFY_TICKETS', 'Failed', null, sqlerrm);
    end;
  end if;
end;
/

begin
  dbms_scheduler.create_job(
    job_name        => 'ATLAS_AI_JOBS',
    job_type        => 'STORED_PROCEDURE',
    job_action      => 'RUN_AI_JOBS',
    repeat_interval => 'FREQ=MINUTELY; INTERVAL=1',
    enabled         => true,
    comments        => 'Embeds and classifies new tickets');
end;
/

select job_name, enabled, state, repeat_interval from user_scheduler_jobs;
