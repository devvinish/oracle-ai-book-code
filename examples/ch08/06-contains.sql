select article_id, title from kb_articles where contains(body, 'refund') > 0;

select article_id, title from kb_articles where contains(body, '$refund') > 0;

select article_id, title, score(1) as score
from   kb_articles
where  contains(body, 'invoice and (duplicate or twice)', 1) > 0
order  by score desc;
