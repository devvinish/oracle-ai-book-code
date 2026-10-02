create or replace function retrieve (
  p_question      in varchar2,
  p_model         in varchar2    default 'MINILM',   -- or 'GEMINI'
  p_k             in pls_integer default 4,          -- at most this many sources
  p_max_distance  in number      default null        -- farther sources are off the subject
) return json
is
  l_vector    vector := embed(p_question, p_model);
  l_max       number := coalesce(p_max_distance,
                                 case p_model when 'GEMINI' then 0.45 else 0.8 end);
  l_sources   json;
begin
  select json_arrayagg(json_object('n' value rownum, 'source' value source,
                                   'distance' value round(distance, 3),
                                   'text' value text returning clob)
                       order by distance returning json)
  into   l_sources
  from  (select k.source, k.text,
                case p_model
                  when 'GEMINI' then vector_distance(k.gemini_embedding, l_vector, cosine)
                  else vector_distance(k.embedding, l_vector, cosine)
                end as distance
         from   knowledge k
         order  by distance
         fetch  first p_k rows only)
  where  distance <= l_max;
  return l_sources;
end;
/

select s.n, s.source, s.distance
from   json_table(retrieve('Can I get my money back for a duplicate charge?'), '$[*]'
         columns (n number path '$.n', source varchar2(60) path '$.source',
                  distance number path '$.distance')) s;
