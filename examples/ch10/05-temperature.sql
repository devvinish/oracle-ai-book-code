-- the same prompt, twice with temperature 0 and twice with temperature 2
with runs (temperature) as (values (0), (0), (2), (2))
select temperature,
       generate('Suggest a subject line for a ticket about a duplicate credit card charge. '
                || 'Answer with the subject line only.',
                p_options => json_object('generationConfig' value
                               json_object('temperature' value temperature) returning json))
         as subject_line
from   runs;
