-- the key is stored in the credential, encrypted; the dictionary shows its name only
select credential_name, username, enabled from user_credentials;

-- and the network access of the schema: one host for Gemini, one port for Ollama
select host, lower_port, upper_port, privilege from user_host_aces order by host;
