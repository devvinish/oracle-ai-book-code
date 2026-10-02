-- @expect-error
-- @cleanup update ai_settings set value = 'Yes' where name = 'AI_ENABLED'
-- the switch off: every AI feature stops at once, with a clear error
update ai_settings set value = 'No' where name = 'AI_ENABLED';
commit;

select ask('Can I get my money back for a duplicate charge?') as answer from dual;

update ai_settings set value = 'Yes' where name = 'AI_ENABLED';
commit;
