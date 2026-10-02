select table_name, comments
from   user_tab_comments
where  table_name in ('PRODUCTS', 'CUSTOMERS', 'AGENTS', 'TICKETS',
                      'TICKET_COMMENTS', 'KB_ARTICLES')
order  by table_name;

select (select count(*) from products)        as products,
       (select count(*) from customers)       as customers,
       (select count(*) from agents)          as agents,
       (select count(*) from tickets)         as tickets,
       (select count(*) from ticket_comments) as comments,
       (select count(*) from kb_articles)     as articles
from   dual;
