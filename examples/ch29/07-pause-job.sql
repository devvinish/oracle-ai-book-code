-- in the lab, the job can be paused, and resumed later with DBMS_SCHEDULER.ENABLE
begin
  dbms_scheduler.disable('ATLAS_AI_JOBS');
end;
/

select job_name, enabled, state, run_count, failure_count from user_scheduler_jobs;
