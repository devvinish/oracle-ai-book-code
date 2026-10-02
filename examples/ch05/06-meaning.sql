-- @setup drop table if exists sentences purge
-- @cleanup drop table if exists sentences purge
create table sentences (id number, text varchar2(200), v vector(384, float32));

insert into sentences (id, text) values (1, 'I cannot sign in to my account');
insert into sentences (id, text) values (2, 'Login keeps saying invalid credentials');
insert into sentences (id, text) values (3, 'We were billed twice this month');
insert into sentences (id, text) values (4, 'Our card shows two identical payments');
insert into sentences (id, text) values (5, 'The mobile app closes right after it opens');

update sentences
set    v = vector_embedding(all_minilm_l12_v2 using text as data);
commit;

select s.id, s.text,
       round(vector_distance(s.v, a.v, cosine), 3) as from_sign_in,
       round(vector_distance(s.v, b.v, cosine), 3) as from_billed_twice
from   sentences s, sentences a, sentences b
where  a.id = 1 and b.id = 3
order  by s.id;
