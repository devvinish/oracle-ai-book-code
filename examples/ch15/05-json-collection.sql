-- @setup drop table if exists ticket_docs purge
-- a JSON collection: one document per ticket, with its embedding
create json collection table ticket_docs;

insert into ticket_docs
select json_object('_id' value ticket_id, 'subject' value subject, 'status' value status,
                   'embedding' value embedding returning json)
from   tickets;
commit;

select json_value(d.data, '$.subject') as subject,
       round(vector_distance(json_value(d.data, '$.embedding' returning vector),
             vector_embedding(all_minilm_l12_v2 using 'charged twice' as data), cosine), 3)
         as distance
from   ticket_docs d
order  by distance
fetch  first 3 rows only;
