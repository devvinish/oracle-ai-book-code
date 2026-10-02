-- @setup delete from ticket_archive where archive_id = 50001
-- @cleanup delete from ticket_archive where archive_id = 50001
insert into ticket_archive (archive_id, product_id, category, subject, description,
                            created_on, embedding)
with t (subject, description) as (
  select 'Dashboard tiles show an hourglass forever',
         'Every tile on our sales dashboard shows an hourglass and never draws the chart.'
  from   dual)
select 50001, 4, 'Bug', subject, description, sysdate,
       vector_embedding(all_minilm_l12_v2 using subject || '. ' || description as data)
from   t;
commit;

select archive_id, subject,
       round(vector_distance(embedding,
             vector_embedding(all_minilm_l12_v2
               using 'dashboard tiles stuck on an hourglass' as data), cosine), 3)
         as distance
from   ticket_archive
order  by distance
fetch  approx first 3 rows only;
