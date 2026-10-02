-- @setup drop table if exists sentences purge
-- @cleanup drop table if exists sentences purge
create table sentences (id number, text varchar2(200), v vector);

insert into sentences (id, text) values (1, 'I cannot sign in to my account');
insert into sentences (id, text) values (2, 'Login keeps saying invalid credentials');
insert into sentences (id, text) values (3, 'We were billed twice this month');
insert into sentences (id, text) values (4, 'Our card shows two identical payments');
insert into sentences (id, text) values (5, 'The mobile app closes right after it opens');

update sentences
set    v = dbms_vector_chain.utl_to_embedding(text,
             json('{"provider": "googleai", "credential_name": "GEMINI_CRED",
                    "url": "https://generativelanguage.googleapis.com/v1beta/models/",
                    "model": "gemini-embedding-001"}'));
commit;

-- every sentence against sentence 1 and sentence 3
select s.id, s.text,
       round(vector_distance(s.v, a.v, cosine), 3) as from_sign_in,
       round(vector_distance(s.v, b.v, cosine), 3) as from_billed_twice
from   sentences s, sentences a, sentences b
where  a.id = 1 and b.id = 3
order  by s.id;
