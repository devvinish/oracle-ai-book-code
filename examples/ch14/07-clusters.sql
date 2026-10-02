-- @setup begin dbms_data_mining.drop_model('TICKET_CLUSTERS'); exception when others then null; end;
declare
  l_settings dbms_data_mining.setting_list;
begin
  l_settings('ALGO_NAME')         := 'ALGO_KMEANS';
  l_settings('CLUS_NUM_CLUSTERS') := '8';
  l_settings('PREP_AUTO')         := 'ON';
  dbms_data_mining.create_model2(
    model_name          => 'TICKET_CLUSTERS',
    mining_function     => 'CLUSTERING',
    data_query          => 'select ticket_id, embedding from ml_tickets',
    set_list            => l_settings,
    case_id_column_name => 'TICKET_ID');
end;
/

select cluster_id(ticket_clusters using embedding) as cluster_id, count(*) as tickets
from   ml_tickets
group  by cluster_id(ticket_clusters using embedding)
order  by cluster_id;
