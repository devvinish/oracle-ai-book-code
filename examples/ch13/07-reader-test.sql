-- @expect-error
select atlas_reader.query_json('select name, current_version from products') as rows_json
from   dual;

select atlas_reader.query_json('select count(*) from atlas.llm_calls') as rows_json
from   dual;
