-- drafts a reply to ticket 9 for Emma Lindqvist of the billing team
declare
  l_id number;
begin
  l_id := hd_draft_reply(9, 'EMMA');
  for r in (select draft from hd_replies where reply_id = l_id) loop
    dbms_output.put_line(r.draft);
  end loop;
end;
/
