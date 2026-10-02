-- the same question, asked by a customer and by an agent
exec atlas_security.set_audience('Customer')
select ask('How large a goodwill credit can be given without approval?') as customer_answer
from   dual;

exec atlas_security.set_audience('Agent')
select ask('How large a goodwill credit can be given without approval?') as agent_answer
from   dual;
