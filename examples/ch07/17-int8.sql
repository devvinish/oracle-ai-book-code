-- @setup begin execute immediate 'alter table ticket_archive drop column embedding_int8'; exception when others then null; end;
alter table ticket_archive add (embedding_int8 vector(384, int8));

-- every number times 400, rounded to a whole number from -127 to 127
update ticket_archive
set    embedding_int8 = to_vector(
         embedding * to_vector('[' || rtrim(rpad('400,', 1536, '400,'), ',') || ']'),
         384, int8);
commit;

select substr(from_vector(embedding returning clob), 1, 50) || '...'      as float32,
       substr(from_vector(embedding_int8 returning clob), 1, 30) || '...' as int8
from   ticket_archive
where  archive_id = 1;
