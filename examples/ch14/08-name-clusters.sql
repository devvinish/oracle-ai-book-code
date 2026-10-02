-- the language model names each cluster from the subjects of its tickets
select c.cluster_id, c.tickets,
       generate('Give a name of at most four words, plain text, to this group of support '
                || 'tickets, from their subjects: ' || c.subjects, 'GEMINI_LITE') as name
from  (select cluster_id(ticket_clusters using m.embedding) as cluster_id,
              count(*) as tickets,
              listagg(distinct t.subject, '; ') as subjects
       from   ml_tickets m join tickets t on t.ticket_id = m.ticket_id
       group  by cluster_id(ticket_clusters using m.embedding)) c
order  by c.tickets desc;
