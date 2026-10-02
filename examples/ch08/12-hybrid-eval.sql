-- the rank of the right article in the results of DBMS_HYBRID_VECTOR.SEARCH
with ranks as (
  select q.question_id, q.article_id as right_id, a.article_id, r.hybrid_rank
  from   eval_questions q,
         json_table(
           dbms_hybrid_vector.search(json_object(
             'hybrid_index_name' value 'KB_ARTICLES_HYBRID',
             'search_text'       value q.question,
             'return'            value json_object('topN' value 10,
                                                   'values' value json_array('rowid'))
             returning json)),
           '$[*]' columns (hybrid_rank for ordinality,
                           row_id varchar2(18) path '$.rowid')) r
         join kb_articles a on a.rowid = chartorowid(r.row_id)
  where  q.lang = 'en')
select count(distinct question_id) as questions,
       count(case when article_id = right_id and hybrid_rank = 1 then 1 end) as first,
       count(case when article_id = right_id and hybrid_rank <= 3 then 1 end) as in_top_3
from   ranks;
