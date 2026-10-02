select p.provider
from   json_table(dbms_vector_chain.list_providers, '$[*]'
         columns (provider varchar2(30) path '$')) p;
