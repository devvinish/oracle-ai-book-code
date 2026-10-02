-- the drafts so far: which were sent, and how much of each the agent kept
select r.reply_id, r.ticket_id, r.agent,
       case when r.sent_at is null then 'Not sent' else 'Sent' end as status,
       r.similarity as kept_percent,
       length(r.draft) as draft_chars,
       length(r.sent)  as sent_chars
from   hd_replies r
order  by r.reply_id;
