select count(*) as matching_tickets
from   ticket_archive
where  product_id = 6
and    created_on >= date '2025-01-01';

-- the 28 questions, searching only archived Atlas Sync tickets (product 6) of 2025:
-- how many approximate results are as near as the 10th result of the exact search?
with q as (
  select question_id, minilm as v from eval_questions where question_id <= 28),
exact as (
  select q.question_id, max(e.distance) as tenth
  from   q cross apply (select vector_distance(embedding, q.v, cosine) as distance
                        from   ticket_archive
                        where  product_id = 6
                        and    created_on >= date '2025-01-01'
                        order  by distance
                        fetch  exact first 10 rows only) e
  group  by q.question_id),
approx as (
  select q.question_id, a.distance
  from   q cross apply (select vector_distance(embedding, q.v, cosine) as distance
                        from   ticket_archive
                        where  product_id = 6
                        and    created_on >= date '2025-01-01'
                        order  by distance
                        fetch  approx first 10 rows only) a)
select count(*) as results,
       sum(case when a.distance <= e.tenth + 1e-6 then 1 else 0 end) as right_results
from   approx a join exact e on e.question_id = a.question_id;
