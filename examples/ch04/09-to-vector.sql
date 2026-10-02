select to_vector('[0.9, 0.05, 0.3]') as from_text from dual;

select to_vector(json_serialize(json_array(0.9, 0.05, 0.3))) as from_json_array from dual;

select to_vector(vector('[0.9, -0.4, 0.05]'), 3, int8) as float32_to_int8 from dual;
