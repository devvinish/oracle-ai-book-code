-- @setup drop view if exists ticket_dv
-- a duality view: tickets and their comments as documents, stored in the relational tables
create json relational duality view ticket_dv as
select json {'_id'      : t.ticket_id,
             'subject'  : t.subject,
             'status'   : t.status,
             'embedding': t.embedding,
             'comments' : [select json {'commentId': c.comment_id,
                                        'author'   : c.author_type,
                                        'body'     : c.body}
                           from   ticket_comments c with insert update delete
                           where  c.ticket_id = t.ticket_id]}
from   tickets t with update;

-- the document of ticket 15, without its embedding
select json_serialize(json_transform(data, remove '$.embedding', remove '$._metadata')
                      returning clob pretty) as document
from   ticket_dv
where  json_value(data, '$._id') = 15;
