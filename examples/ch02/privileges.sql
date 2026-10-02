select role from session_roles order by role;

select privilege from session_privs
where  privilege in ('CREATE MINING MODEL', 'CREATE CREDENTIAL')
order  by privilege;

select host, privilege from user_host_aces;
