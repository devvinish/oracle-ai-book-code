-- @setup begin dbms_rls.drop_policy('ATLAS', 'DOC_CHUNKS', 'DOC_AUDIENCE'); exception when others then null; end;
-- @setup delete from atlas_documents where file_name = 'goodwill-credits.txt'
-- @setup begin execute immediate 'alter table atlas_documents drop column audience'; exception when others then null; end;
-- every document is for customers (Public) or for agents only (Internal)
alter table atlas_documents add (audience varchar2(10) default 'Public' not null
  constraint atlas_documents_audience_ck check (audience in ('Public', 'Internal')));

-- the session says who is asking; the policy decides which chunks it may see
create or replace package atlas_security is
  procedure set_audience (p_audience in varchar2);
  function documents_policy (p_schema in varchar2, p_object in varchar2)
    return varchar2;
end;
/
create or replace package body atlas_security is
  procedure set_audience (p_audience in varchar2) is
  begin
    dbms_session.set_context('ATLAS_CTX', 'AUDIENCE', p_audience);
  end;

  function documents_policy (p_schema in varchar2, p_object in varchar2)
    return varchar2
  is
  begin
    if sys_context('ATLAS_CTX', 'AUDIENCE') = 'Agent' then
      return null;                                            -- agents see every chunk
    end if;
    return 'doc_id in (select doc_id from atlas_documents where audience = ''Public'')';
  end;
end;
/

begin
  dbms_rls.add_policy(
    object_schema   => 'ATLAS',
    object_name     => 'DOC_CHUNKS',
    policy_name     => 'DOC_AUDIENCE',
    function_schema => 'ATLAS',
    policy_function => 'ATLAS_SECURITY.DOCUMENTS_POLICY',
    statement_types => 'SELECT');
end;
/

-- an internal document: for agents only
declare
  l_doc_id number;
begin
  atlas_security.set_audience('Agent');      -- the chunks are inserted and read back
  l_doc_id := add_document(
    p_file_name  => 'goodwill-credits.txt',
    p_doc_type   => 'Manual',
    p_title      => 'Goodwill credits (internal)',
    p_product_id => 2,
    p_content    => to_blob(utl_raw.cast_to_raw(
      'Goodwill credits. Agents may give a customer a goodwill credit of up to '
      || '50 US dollars for an outage or a billing mistake, without approval. Team leads '
      || 'approve credits up to 200 US dollars; larger credits need the head of '
      || 'support.')));
  update atlas_documents set audience = 'Internal', reviewed_on = sysdate
  where  doc_id = l_doc_id;
  commit;
end;
/
