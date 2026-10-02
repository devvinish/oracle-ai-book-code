-- @setup drop function if exists topic_vector
create or replace function topic_vector (
  p_account   number,
  p_billing   number,
  p_technical number
) return vector
is
  v vector(3, float32);
begin
  v := to_vector('[' || p_account || ',' || p_billing || ',' || p_technical || ']');
  return v;
end;
/

select article_id,
       round(vector_distance(topics, topic_vector(0.1, 0.1, 0.9)), 4) as distance
from   article_topics
order  by distance
fetch  first 2 rows only;

declare
  v_ticket   vector(3, float32) := topic_vector(0.2, 0.8, 0.1);
  v_distance number;
begin
  select min(vector_distance(topics, v_ticket)) into v_distance from article_topics;
  dbms_output.put_line('Dimensions: ' || vector_dimension_count(v_ticket));
  dbms_output.put_line('Closest article is ' || round(v_distance, 4) || ' away');
end;
/
