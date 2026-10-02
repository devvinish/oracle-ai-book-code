select article_id,
       round(cosine_distance(topics, vector('[0.10, 0.90, 0.15]')), 4) as cosine_distance,
       round(topics <=> vector('[0.10, 0.90, 0.15]'), 4)              as "<=>",
       round(l2_distance(topics, vector('[0.10, 0.90, 0.15]')), 4)     as l2_distance,
       round(topics <-> vector('[0.10, 0.90, 0.15]'), 4)              as "<->",
       round(inner_product(topics, vector('[0.10, 0.90, 0.15]')), 4)   as inner_product,
       round(topics <#> vector('[0.10, 0.90, 0.15]'), 4)              as "<#>"
from   article_topics
where  article_id in ('KB-201', 'KB-301');
