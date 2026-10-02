create or replace function ask_data (p_question in varchar2) return json
is
  l_sql    clob := generate_sql(p_question);
  l_error  varchar2(4000) := check_sql(l_sql);
  l_rows   clob;
begin
  if l_error is null then
    begin
      l_rows := atlas_reader.query_json(l_sql);
    exception
      when others then l_error := sqlerrm;
    end;
  end if;
  return json_object('question' value p_question, 'sql' value l_sql,
                     'rows' value json(l_rows), 'error' value l_error
                     absent on null returning json);
end;
/

select json_serialize(ask_data('Which three agents resolved the most tickets?') pretty)
         as result
from   dual;
