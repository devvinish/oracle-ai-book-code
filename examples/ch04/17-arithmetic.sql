select vector('[1, 2, 3]') + vector('[10, 20, 30]') as added,
       vector('[10, 20, 30]') - vector('[1, 2, 3]') as subtracted,
       vector('[1, 2, 3]') * vector('[2, 0.5, 0]')  as multiplied
from   dual;

-- the centre of the two billing articles
select avg(topics) as billing_centre
from   article_topics
where  article_id in ('KB-201', 'KB-203');
