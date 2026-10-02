select round(vector_distance(
         dbms_vector.utl_to_embedding('I cannot sign in to my account',
           json('{"provider": "database", "model": "ALL_MINILM_L12_V2"}')),
         vector_embedding(all_minilm_l12_v2
                          using 'I cannot sign in to my account' as data)),
       6) as distance
from   dual;

declare
  v vector;
begin
  v := dbms_vector.utl_to_embedding('I cannot sign in to my account',
         json('{"provider": "database", "model": "ALL_MINILM_L12_V2"}'));
  dbms_output.put_line('Dimensions: ' || vector_dimension_count(v));
end;
/
