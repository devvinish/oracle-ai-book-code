-- @setup drop sequence if exists tickets_seq
-- new tickets entered in APEX get their number and creation time from the database;
-- ON NULL: the form inserts null into both, which a plain default would keep
create sequence tickets_seq start with 10001;

alter table tickets modify (ticket_id  default on null tickets_seq.nextval,
                            created_at default on null systimestamp);
