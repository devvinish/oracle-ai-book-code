-- @setup begin dbms_vector.drop_onnx_model('MINILM_COPY', force => true); exception when others then null; end;
-- the same model, loaded from a BLOB under another name
begin
  dbms_vector.load_onnx_model(
    model_name => 'MINILM_COPY',
    model_data => to_blob(bfilename('ATLAS_FILES', 'all_MiniLM_L12_v2.onnx')));
end;
/

select model_name from user_mining_models order by model_name;

begin
  dbms_vector.drop_onnx_model(model_name => 'MINILM_COPY');
end;
/

select model_name from user_mining_models order by model_name;
