select vector('[0.123456789]', 1, float64) as float64_value,
       vector('[0.123456789]', 1, float32) as float32_value,
       vector('[1.6, -2.4, 100]', 3, int8) as int8_value
from   dual;
