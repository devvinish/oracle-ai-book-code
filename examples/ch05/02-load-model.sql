-- @setup begin dbms_vector.drop_onnx_model('ALL_MINILM_L12_V2', force => true); exception when others then null; end;
begin
  dbms_vector.load_onnx_model(
    directory  => 'ATLAS_FILES',
    file_name  => 'all_MiniLM_L12_v2.onnx',
    model_name => 'ALL_MINILM_L12_V2');
end;
/
