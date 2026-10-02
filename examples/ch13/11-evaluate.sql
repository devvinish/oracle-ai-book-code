-- @setup drop table if exists nl2sql_tests purge
-- questions with one-number answers, and the SQL that gives the right number
create table nl2sql_tests (
  test_id        number constraint nl2sql_tests_pk primary key,
  question       varchar2(200) not null,
  reference_sql  varchar2(1000) not null
);

insert into nl2sql_tests values
  (1, 'How many tickets are there?', 'select count(*) from tickets'),
  (2, 'How many tickets are still open?',
      'select count(*) from tickets where status = ''Open'''),
  (3, 'How many customers are on the Enterprise plan?',
      'select count(*) from customers where plan = ''Enterprise'''),
  (4, 'How many tickets did Priya Raman handle?',
      'select count(*) from tickets t join agents a on a.agent_id = t.agent_id
       where a.name = ''Priya Raman'''),
  (5, 'How many urgent tickets came from customers in India?',
      'select count(*) from tickets t join customers c on c.customer_id = t.customer_id
       where t.priority = ''Urgent'' and c.country = ''India'''),
  (6, 'How many Atlas Mobile tickets came in by chat?',
      'select count(*) from tickets t join products p on p.product_id = t.product_id
       where p.name = ''Atlas Mobile'' and t.channel = ''Chat'''),
  (7, 'How many knowledge base articles are about Atlas Billing?',
      'select count(*) from kb_articles a join products p on p.product_id = a.product_id
       where p.name = ''Atlas Billing'''),
  (8, 'How many tickets were created in March 2026?',
      'select count(*) from tickets
       where created_at >= date ''2026-03-01'' and created_at < date ''2026-04-01'''),
  (9, 'What is the average satisfaction rating, rounded to one decimal?',
      'select round(avg(satisfaction), 1) from tickets'),
  (10, 'Which customer company has the most tickets?',
      'select c.company from tickets t join customers c on c.customer_id = t.customer_id
       group by c.company order by count(*) desc fetch first 1 row only'));
commit;

-- the first value of the first row, from each generated query and each reference query
select test_id, generated, expected,
       case when generated = expected then 'yes' else 'NO' end as same
from  (select t.test_id,
              json_query(json_query(ask_data(t.question), '$.rows[0]'),
                         '$.*' returning varchar2(100) with wrapper) as generated,
              json_query(json_query(atlas_reader.query_json(t.reference_sql), '$[0]'),
                         '$.*' returning varchar2(100) with wrapper) as expected
       from   nl2sql_tests t)
order  by test_id;
