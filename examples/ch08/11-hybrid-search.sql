select a.article_id, a.title, r.score, r.vector_score, r.text_score
from   json_table(
         dbms_hybrid_vector.search(json('{
           "hybrid_index_name": "KB_ARTICLES_HYBRID",
           "search_text": "What does the Retry-After header mean?",
           "return": {"topN": 3,
                      "values": ["rowid", "score", "vector_score", "text_score"]}}')),
         '$[*]' columns (row_id        varchar2(18) path '$.rowid',
                         score         number       path '$.score',
                         vector_score  number       path '$.vector_score',
                         text_score    number       path '$.text_score')) r
join   kb_articles a on a.rowid = chartorowid(r.row_id);
