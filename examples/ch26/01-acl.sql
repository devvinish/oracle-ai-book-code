-- @connect sysdba
-- ATLAS may call the Ollama server on the host computer, port 11434
begin
  dbms_network_acl_admin.append_host_ace(
    host       => 'host.docker.internal',
    lower_port => 11434,
    upper_port => 11434,
    ace        => xs$ace_type(privilege_list => xs$name_list('http'),
                              principal_name => 'ATLAS',
                              principal_type => xs_acl.ptype_db));
end;
/
