-- @setup begin dbms_data_mining.drop_model('CATEGORY_SVM'); exception when others then null; end;
declare
  l_settings dbms_data_mining.setting_list;
begin
  l_settings('ALGO_NAME') := 'ALGO_SUPPORT_VECTOR_MACHINES';
  l_settings('PREP_AUTO') := 'ON';
  dbms_data_mining.create_model2(
    model_name          => 'CATEGORY_SVM',
    mining_function     => 'CLASSIFICATION',
    data_query          => 'select ticket_id, category, embedding from ml_tickets
                            where data_set = ''Train''',
    set_list            => l_settings,
    case_id_column_name => 'TICKET_ID',
    target_column_name  => 'CATEGORY');
end;
/

select model_name, mining_function, algorithm, round(build_duration, 1) as build_seconds
from   user_mining_models
where  model_name = 'CATEGORY_SVM';
