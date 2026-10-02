-- drafts ticket 85 again with the second version, and compares the draft with what
-- Daniel Okafor sent
declare
  l_id    number;
  l_draft clob;
  l_sent  clob;
begin
  l_id := hd_draft_reply(85, 'DANIEL');
  select draft into l_draft from hd_replies where reply_id = l_id;
  select sent into l_sent from hd_replies where ticket_id = 85 and sent is not null;
  dbms_output.put_line(l_draft);
  dbms_output.put_line('');
  dbms_output.put_line('Kept: ' || utl_match.edit_distance_similarity(
                                     dbms_lob.substr(l_draft, 4000),
                                     dbms_lob.substr(l_sent, 4000)) || '%');
end;
/
