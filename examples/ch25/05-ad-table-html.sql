-- the rows of an answer as an HTML table, whatever its columns, every value escaped
create or replace function ad_table_html (p_question_id in number) return clob
is
  l_result json;
  l_rows   json_array_t;
  l_row    json_object_t;
  l_keys   json_key_list;
  l_value  json_element_t;
  l_html   clob;
begin
  select result into l_result from ad_questions where question_id = p_question_id;
  if l_result is null then
    return null;
  end if;
  l_rows := json_array_t(json_serialize(l_result));
  if l_rows.get_size = 0 then
    return '<p>No rows.</p>';
  end if;

  l_keys := json_object_t(l_rows.get(0)).get_keys;
  l_html := '<table class="t-Report-report"><tr>';
  for k in 1 .. l_keys.count loop
    l_html := l_html || '<th class="t-Report-colHead">' || apex_escape.html(initcap(
                replace(l_keys(k), '_', ' '))) || '</th>';
  end loop;
  l_html := l_html || '</tr>';

  for i in 0 .. l_rows.get_size - 1 loop
    l_row  := json_object_t(l_rows.get(i));
    l_html := l_html || '<tr>';
    for k in 1 .. l_keys.count loop
      l_value := l_row.get(l_keys(k));
      l_html  := l_html || '<td class="t-Report-cell">'
                 || case when l_value.is_null   then null
                         when l_value.is_string
                           then apex_escape.html(l_row.get_string(l_keys(k)))
                         else apex_escape.html(l_value.to_string) end
                 || '</td>';
    end loop;
    l_html := l_html || '</tr>';
  end loop;
  return l_html || '</table>';
end;
/
select ad_table_html(question_id) as html
from   ad_questions
where  question like 'Which agent%';
