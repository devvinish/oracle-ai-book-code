-- @expect-error
-- returns null when the statement may run, or the reason it may not
create or replace function check_sql (p_sql in clob) return varchar2
is
  pragma autonomous_transaction;         -- EXPLAIN PLAN writes to PLAN_TABLE
  l_operation  varchar2(30);
  l_forbidden  varchar2(4000);
begin
  if not regexp_like(p_sql, '^\s*(select|with)\s', 'i') then
    return 'not a query';
  end if;
  if instr(p_sql, ';') > 0 then
    return 'more than one statement';
  end if;

  delete from plan_table where statement_id = 'NL2SQL';
  begin
    execute immediate 'explain plan set statement_id = ''NL2SQL'' for ' || p_sql;
  exception
    when others then
      rollback;
      return 'invalid SQL: ' || sqlerrm;
  end;

  select max(case when id = 0 then operation end),
         listagg(distinct case when object_type like 'TABLE%'
                                and object_name not in (select table_name
                                                        from   nl2sql_tables)
                               then object_name end, ', ')
  into   l_operation, l_forbidden
  from   plan_table
  where  statement_id = 'NL2SQL';
  rollback;

  return case
           when l_operation <> 'SELECT STATEMENT' then 'not a query'
           when l_forbidden is not null then 'uses tables not allowed: ' || l_forbidden
         end;
end;
/

with statements (s) as (
  values ('select count(*) from tickets'),
         ('delete from tickets'),
         ('select prompt from llm_calls'),
         ('select * from tickets; drop table tickets'),
         ('select no_such_column from tickets'))
select s as statement, substr(nvl(check_sql(s), 'allowed'), 1, 50) as result
from   statements;
