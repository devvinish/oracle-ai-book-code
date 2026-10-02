-- @setup drop table if exists article_topics purge
-- each knowledge base article scored from 0 to 1 on three topics:
-- [account, billing, technical]
create table article_topics (
  article_id  varchar2(10) constraint article_topics_pk primary key
              constraint article_topics_fk references kb_articles,
  topics      vector(3, float32) not null
);

insert into article_topics values ('KB-101', '[0.90, 0.05, 0.30]');  -- sign-in problems
insert into article_topics values ('KB-105', '[0.85, 0.05, 0.40]');  -- suspicious sign-in
insert into article_topics values ('KB-201', '[0.10, 0.95, 0.10]');  -- duplicate charges
insert into article_topics values ('KB-203', '[0.05, 0.90, 0.20]');  -- taxes and VAT
insert into article_topics values ('KB-301', '[0.10, 0.05, 0.95]');  -- pipeline page bug
insert into article_topics values ('KB-401', '[0.15, 0.00, 0.90]');  -- mobile app crash
commit;

select article_id, topics
from   article_topics
order  by article_id;
