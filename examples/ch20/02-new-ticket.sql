-- the ticket created on the form: classified and embedded when it was saved
select ticket_id, priority, ai_category, ai_priority, ai_sentiment,
       vector_dimension_count(embedding) as embedding
from   tickets
where  ticket_id = 10001;
