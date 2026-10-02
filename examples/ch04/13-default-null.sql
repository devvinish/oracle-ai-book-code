select round(vector_distance(vector('[1, 0]'), vector('[0, 1]')), 4) as default_metric,
       vector_distance(vector('[1, 0]'), null)                       as with_null
from   dual;
