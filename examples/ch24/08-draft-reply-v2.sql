-- drafts a reply from the resolutions of similar tickets and the nearest articles
-- (second version: the customer's plan, and steps only for actions on the account)
create or replace function hd_draft_reply (
  p_ticket_id in number,
  p_user      in varchar2
) return number
is
  c_instructions constant varchar2(1000) :=
    'You draft replies for the support agents of Atlas Software. Write to the customer by '
    || 'first name. Use only the facts in the earlier resolutions and the articles. Never '
    || 'say that an action on the account was taken; write each such action the agent must '
    || 'take in square brackets, like [refund issued], and nothing else in brackets. Use '
    || 'the customer''s plan where it matters. Mention an article by its ID when you '
    || 'use it. '
    || 'Plain text, at most 120 words, signed with the agent''s name.';
  l_agent   agents.name%type;
  l_prompt  clob;
  l_draft   clob;
  l_id      hd_replies.reply_id%type;
begin
  -- the agent, from the user name: EMMA is emma.lindqvist@atlas.example
  select max(name) into l_agent
  from   agents
  where  upper(substr(email, 1, instr(email, '.') - 1)) = upper(p_user);

  select 'Agent: ' || nvl(l_agent, 'Atlas Support') || chr(10)
         || 'Customer: ' || c.contact_name || ', ' || c.company
         || ', plan ' || c.plan || chr(10)
         || 'Ticket: ' || t.subject || chr(10) || t.description || chr(10) || chr(10)
         || 'Resolutions of similar tickets:' || chr(10)
         || (select listagg('- ' || r.resolution, chr(10))
             from   (select (select c2.body
                             from   ticket_comments c2
                             where  c2.ticket_id = s.ticket_id and c2.author_type = 'Agent'
                             order  by c2.created_at desc
                             fetch  first 1 row only) as resolution
                     from   tickets s
                     where  s.ticket_id <> t.ticket_id
                     and    s.status in ('Resolved', 'Closed')
                     order  by vector_distance(s.embedding, t.embedding, cosine)
                     fetch  first 3 rows only) r) || chr(10) || chr(10)
         || 'Articles:' || chr(10)
         || (select listagg(a.article_id || ' ' || a.title || ': ' || a.body, chr(10))
             from   (select article_id, title, body
                     from   kb_articles
                     order  by vector_distance(embedding, t.embedding, cosine)
                     fetch  first 2 rows only) a)
  into   l_prompt
  from   tickets t join customers c on c.customer_id = t.customer_id
  where  t.ticket_id = p_ticket_id;

  l_draft := generate(l_prompt, 'GEMINI', json_object(
    'systemInstruction' value json_object('parts' value json_array(
                                json_object('text' value c_instructions))),
    'generationConfig'  value json('{"temperature": 0.3,
                                     "thinkingConfig": {"thinkingBudget": 0}}')
    returning json));

  insert into hd_replies (ticket_id, agent, draft)
  values (p_ticket_id, p_user, l_draft)
  returning reply_id into l_id;
  return l_id;
end;
/
