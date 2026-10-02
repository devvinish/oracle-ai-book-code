select model_name, mining_function, algorithm,
       round(model_size / 1024 / 1024) as size_mb
from   user_mining_models;

select attribute_name, attribute_type, data_type, vector_info
from   user_mining_model_attributes
where  model_name = 'ALL_MINILM_L12_V2';
