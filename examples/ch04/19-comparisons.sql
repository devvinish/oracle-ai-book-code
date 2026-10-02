-- @expect-error
select count(*) from article_topics where topics = vector('[0.90, 0.05, 0.30]');

select article_id from article_topics order by topics;

create index article_topics_ix on article_topics (topics);

-- the same test, done with a distance
select article_id
from   article_topics
where  vector_distance(topics, vector('[0.90, 0.05, 0.30]'), euclidean) = 0;
