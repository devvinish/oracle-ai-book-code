-- answers a question with ASK_DATA, puts the rows into a sentence, and keeps the points of
-- a chart when the rows are pairs of a label and a number
create or replace function ad_ask (
  p_question in varchar2,
  p_user     in varchar2
) return number
is
  l_result json := ask_data(p_question);
  l_rows   json_array_t;
  l_row    json_object_t;
  l_keys   json_key_list;
  l_label  ad_points.label%type;
  l_value  ad_points.value%type;
  l_count  number;
  l_id     ad_questions.question_id%type;
  l_answer varchar2(2000);
begin
  insert into ad_questions (asked_by, question, sql_text, result, error)
  values (p_user, p_question,
          json_value(l_result, '$.sql' returning clob),
          json_query(l_result, '$.rows' returning json),
          json_value(l_result, '$.error' returning varchar2(4000)))
  returning question_id into l_id;

  if json_exists(l_result, '$.rows') then
    l_rows  := json_array_t(json_query(l_result, '$.rows' returning clob));
    l_count := l_rows.get_size;

    -- one sentence that answers the question from the rows
    l_answer := generate(
      'Question: ' || p_question || chr(10)
      || 'SQL: ' || json_value(l_result, '$.sql' returning clob) || chr(10)
      || 'Rows: ' || json_query(l_result, '$.rows' returning clob) || chr(10) || chr(10)
      || 'Answer the question in one sentence from the rows. If the SQL counted something '
      || 'narrower or broader than the question asked, say what it counted.',
      'GEMINI',
      json('{"generationConfig": {"thinkingConfig": {"thinkingBudget": 0}}}'));

    -- the points of a chart: rows of exactly two columns, the second a number
    for i in 0 .. l_rows.get_size - 1 loop
      l_row  := json_object_t(l_rows.get(i));
      l_keys := l_row.get_keys;
      exit when l_keys.count <> 2 or not l_row.get(l_keys(2)).is_number;
      l_label := l_row.get_string(l_keys(1));
      l_value := l_row.get_number(l_keys(2));
      insert into ad_points (question_id, seq, label, value)
      values (l_id, i + 1, l_label, l_value);
    end loop;
  end if;

  update ad_questions
  set    row_count = l_count,
         answer    = l_answer
  where  question_id = l_id;
  return l_id;
end;
/
