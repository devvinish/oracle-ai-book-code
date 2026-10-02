-- @expect-error
select vector_distance(topics, vector('[0.10, 0.90]'))
from   article_topics;
