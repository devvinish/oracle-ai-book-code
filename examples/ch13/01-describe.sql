-- @setup drop table if exists nl2sql_tables purge
-- the tables questions may use, and a function that describes them for the model
create table nl2sql_tables (
  table_name varchar2(128) constraint nl2sql_tables_pk primary key
);
insert into nl2sql_tables values
  ('PRODUCTS'), ('CUSTOMERS'), ('AGENTS'), ('TICKETS'), ('TICKET_COMMENTS'),
  ('KB_ARTICLES');
commit;

create or replace function describe_schema return clob
is
  l_text    clob;
  l_values  varchar2(4000);
begin
  for t in (select n.table_name, c.comments
            from   nl2sql_tables n
            left   join user_tab_comments c on c.table_name = n.table_name
            order  by n.table_name) loop
    l_text := l_text || 'Table ' || t.table_name
              || case when t.comments is not null then ' -- ' || t.comments end || chr(10);
    for c in (select col.column_name, col.data_type, cc.comments
              from   user_tab_columns col
              left   join user_col_comments cc
                     on  cc.table_name = col.table_name
                     and cc.column_name = col.column_name
              where  col.table_name = t.table_name
              and    col.data_type not like 'VECTOR%'
              and    col.column_name not like 'AI\_%' escape '\'
              order  by col.column_id) loop
      -- the values of a text column with few, short values: 'Open', 'Closed', ...
      l_values := null;
      if c.data_type = 'VARCHAR2' then
        begin
          execute immediate 'select listagg(distinct ''''''''|| ' || c.column_name
                            || ' || '''''''', '', '') from ' || t.table_name
                            || ' having count(distinct ' || c.column_name || ') <= 8'
                            || ' and max(length(' || c.column_name || ')) <= 20'
            into l_values;
        exception
          when no_data_found then null;         -- many or long values: list none
        end;
      end if;
      l_text := l_text || '  ' || c.column_name || ' ' || c.data_type
                || case when c.comments is not null then ' -- ' || c.comments end
                || case when l_values is not null then ' values: ' || l_values end
                || chr(10);
    end loop;
  end loop;
  -- how the tables join
  for f in (select c.table_name, cc.column_name, r.table_name as ref_table
            from   user_constraints c
            join   user_cons_columns cc on cc.constraint_name = c.constraint_name
            join   user_constraints r on r.constraint_name = c.r_constraint_name
            where  c.constraint_type = 'R'
            and    c.table_name in (select table_name from nl2sql_tables)
            and    r.table_name in (select table_name from nl2sql_tables)
            order  by 1, 2) loop
    l_text := l_text || 'Join ' || f.table_name || '.' || f.column_name
              || ' to ' || f.ref_table || chr(10);
  end loop;
  return l_text;
end;
/

select describe_schema() as schema_description from dual;
