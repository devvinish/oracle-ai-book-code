-- @setup begin dbms_data_mining.drop_model('PRIORITY_TREE'); exception when others then null; end;
-- priority from the customer's plan, the product, the category, and the channel
declare
  l_settings dbms_data_mining.setting_list;
begin
  l_settings('ALGO_NAME') := 'ALGO_DECISION_TREE';
  l_settings('PREP_AUTO') := 'ON';
  dbms_data_mining.create_model2(
    model_name          => 'PRIORITY_TREE',
    mining_function     => 'CLASSIFICATION',
    data_query          => 'select ticket_id, priority, plan, product_id, category, channel
                            from ml_tickets where data_set = ''Train''',
    set_list            => l_settings,
    case_id_column_name => 'TICKET_ID',
    target_column_name  => 'PRIORITY');
end;
/

select count(*) as tickets,
       count(case when prediction(priority_tree using m.*) = m.priority then 1 end)
         as decision_tree,
       count(case when t.ai_priority = m.priority then 1 end) as language_model,
       count(case when m.priority = 'Normal' then 1 end) as always_normal
from   ml_tickets m join tickets t on t.ticket_id = m.ticket_id
where  m.data_set = 'Test';
