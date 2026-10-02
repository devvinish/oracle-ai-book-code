-- @expect-error
create or replace trigger tickets_embedding_trg
before insert or update of subject, description on tickets
for each row
begin
  null;
end;
/

create or replace trigger tickets_embedding_trg
before insert or update on tickets
for each row
begin
  if inserting
     or :new.subject <> :old.subject
     or dbms_lob.compare(:new.description, :old.description) <> 0
  then
    select vector_embedding(all_minilm_l12_v2
             using :new.subject || '. ' || :new.description as data)
    into   :new.embedding
    from   dual;
  end if;
end;
/

insert into tickets (ticket_id, customer_id, product_id, subject, description,
                     priority, status, category, channel, created_at)
values (9001, 1, 2, 'Payment taken twice',
        'Our bank statement shows the same Atlas payment two times this month.',
        'High', 'Open', 'Billing', 'Email', systimestamp);

select ticket_id, vector_dimension_count(embedding) as dimensions
from   tickets
where  ticket_id = 9001;

rollback;
