-- a vector inside a JSON document is a vector, not text
select json_serialize(
         json_object('ticket' value 9, 'topics' value vector('[0.1, 0.9, 0.15]')
                     returning json) extended) as document
from   dual;

select json_value(doc, '$.topics.type()') as json_type,
       json_value(doc, '$.topics' returning vector) as topics
from  (select json_object('topics' value vector('[0.1, 0.9, 0.15]') returning json) as doc
       from   dual);
