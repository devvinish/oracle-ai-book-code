-- @setup drop sequence if exists ticket_comments_seq
-- sends a reply: records it as the agent's comment, measures how much of the draft was
-- kept, and sets the ticket to Waiting for the customer
create sequence ticket_comments_seq start with 1001;

create or replace procedure hd_send_reply (
  p_reply_id in number,
  p_text     in clob
)
is
  l_reply hd_replies%rowtype;
  l_agent agents.name%type;
begin
  select * into l_reply from hd_replies where reply_id = p_reply_id for update;

  select max(name) into l_agent
  from   agents
  where  upper(substr(email, 1, instr(email, '.') - 1)) = upper(l_reply.agent);

  insert into ticket_comments (comment_id, ticket_id, author_type, author_name, body,
                               created_at)
  values (ticket_comments_seq.nextval, l_reply.ticket_id, 'Agent',
          nvl(l_agent, l_reply.agent), p_text, systimestamp);

  update hd_replies
  set    sent       = p_text,
         sent_at    = systimestamp,
         similarity = utl_match.edit_distance_similarity(dbms_lob.substr(draft, 4000),
                                                         dbms_lob.substr(p_text, 4000))
  where  reply_id = p_reply_id;

  update tickets
  set    status = 'Waiting'
  where  ticket_id = l_reply.ticket_id and status in ('Open', 'In Progress');
end;
/
