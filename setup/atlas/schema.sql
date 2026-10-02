-- The Atlas Support schema (tables, constraints, comments). Run as ATLAS.
create table products (
  product_id       number        constraint products_pk primary key,
  name             varchar2(60)  not null constraint products_name_uk unique,
  category         varchar2(30)  not null,
  current_version  varchar2(10)  not null,
  description      varchar2(400) not null
);

create table customers (
  customer_id      number        constraint customers_pk primary key,
  company          varchar2(80)  not null,
  contact_name     varchar2(80)  not null,
  email            varchar2(120) not null,
  country          varchar2(60)  not null,
  plan             varchar2(20)  not null constraint customers_plan_ck check (plan in ('Basic', 'Professional', 'Enterprise')),
  customer_since   date          not null
);

create table agents (
  agent_id         number        constraint agents_pk primary key,
  name             varchar2(80)  not null,
  team             varchar2(30)  not null,
  email            varchar2(120) not null
);

create table tickets (
  ticket_id        number        constraint tickets_pk primary key,
  customer_id      number        not null constraint tickets_customer_fk references customers,
  product_id       number        not null constraint tickets_product_fk references products,
  agent_id         number        constraint tickets_agent_fk references agents,
  subject          varchar2(200) not null,
  description      clob          not null,
  priority         varchar2(10)  not null constraint tickets_priority_ck check (priority in ('Low', 'Normal', 'High', 'Urgent')),
  status           varchar2(15)  not null constraint tickets_status_ck check (status in ('Open', 'In Progress', 'Waiting', 'Resolved', 'Closed')),
  category         varchar2(20)  not null,
  channel          varchar2(10)  not null,
  created_at       timestamp     not null,
  resolved_at      timestamp,
  satisfaction     number(1)     constraint tickets_satisfaction_ck check (satisfaction between 1 and 5)
);
create index tickets_customer_ix on tickets (customer_id);
create index tickets_product_ix on tickets (product_id);
create index tickets_agent_ix on tickets (agent_id);

create table ticket_comments (
  comment_id       number        constraint ticket_comments_pk primary key,
  ticket_id        number        not null constraint ticket_comments_ticket_fk references tickets,
  author_type      varchar2(10)  not null constraint ticket_comments_author_ck check (author_type in ('Customer', 'Agent')),
  author_name      varchar2(80)  not null,
  body             clob          not null,
  created_at       timestamp     not null
);
create index ticket_comments_ticket_ix on ticket_comments (ticket_id);

create table kb_articles (
  article_id       varchar2(10)  constraint kb_articles_pk primary key,
  product_id       number        constraint kb_articles_product_fk references products,
  title            varchar2(120) not null,
  body             clob          not null,
  updated_on       date          not null
);

comment on table products        is 'The six software products of Atlas Software';
comment on table customers       is 'Companies that use Atlas products, with their main contact';
comment on table agents          is 'The support agents of Atlas Support';
comment on table tickets         is 'Support requests: what the customer wrote, priority, status, and outcome';
comment on table ticket_comments is 'The conversation of each ticket after the first message';
comment on table kb_articles     is 'Knowledge base: short help articles that answer common questions';
comment on column tickets.satisfaction is 'Customer rating from 1 (poor) to 5 (excellent), given when the ticket is closed';
comment on column kb_articles.product_id is 'The product the article is about; null for articles about the Atlas account';
