select from_vector(topics returning varchar2(100)) as as_varchar2
from   article_topics
where  article_id = 'KB-201';

select vector_serialize(topics returning clob) as as_clob
from   article_topics
where  article_id = 'KB-201';
