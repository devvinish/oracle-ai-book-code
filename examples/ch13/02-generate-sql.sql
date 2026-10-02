create or replace function generate_sql (p_question in varchar2) return clob
is
  l_answer clob;
begin
  l_answer := generate(
    'Write one Oracle SQL query that answers the question, using only the tables below. '
    || 'Return a single SELECT statement without a semicolon. Use the values exactly '
    || 'as listed. Today is ' || to_char(sysdate, 'DD Month YYYY') || '.' || chr(10)
    || describe_schema() || chr(10) || 'Question: ' || p_question,
    'GEMINI',
    json('{"generationConfig": {"temperature": 0,
           "responseMimeType": "application/json",
           "responseSchema": {"type": "OBJECT",
                              "properties": {"sql": {"type": "STRING"}},
                              "required": ["sql"]}}}'));
  return json_value(l_answer, '$.sql' returning clob);
end;
/

select generate_sql('How many open tickets does each product have?') as generated_sql
from   dual;
