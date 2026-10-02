-- @setup begin apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN'); end;
select vector_dimension_count(v) as dimensions,
       round(vector_distance(v, (select embedding from kb_articles
                                 where article_id = 'KB-401'), cosine), 3)
         as distance_to_kb_401
from  (select apex_ai.get_vector_embeddings(
                p_value             => 'The phone app closes right after I open it',
                p_service_static_id => 'atlas-minilm') as v
       from   dual);
