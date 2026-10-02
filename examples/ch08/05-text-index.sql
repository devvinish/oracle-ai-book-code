-- @setup drop index if exists kb_articles_hybrid force
-- @setup drop index if exists kb_articles_text force
create index kb_articles_text on kb_articles (body)
  indextype is ctxsys.context;
