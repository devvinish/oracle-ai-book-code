select vector_dimension_count(v)  as dimensions,
       vector_dimension_format(v) as format,
       round(vector_norm(v), 4)   as length,
       substr(from_vector(v returning clob), 1, 44) || '...' as first_numbers
from  (select vector_embedding(all_minilm_l12_v2
                using 'I cannot sign in to my account' as data) as v
       from   dual);
