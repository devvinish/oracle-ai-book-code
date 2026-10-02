select article_id,
       vector_dimension_count(topics)  as dims,
       vector_dimension_format(topics) as format,
       round(vector_norm(topics), 4)   as norm
from   article_topics
order  by article_id;
