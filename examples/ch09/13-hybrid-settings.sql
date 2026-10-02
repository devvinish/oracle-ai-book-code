select ixv_attribute as setting, ixv_value as value
from   ctx_user_index_values
where  ixv_index_name = 'ATLAS_DOCUMENTS_HYBRID'
and   (ixv_attribute like 'CHUNK%' or ixv_attribute like 'VECTOR%'
       or ixv_attribute = 'MODEL_NAME')
order  by ixv_attribute;

select idx_sync_type, idx_sync_interval
from   ctx_user_indexes
where  idx_name = 'ATLAS_DOCUMENTS_HYBRID';
