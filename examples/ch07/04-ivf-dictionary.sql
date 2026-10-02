select index_name, index_type, index_subtype, status
from   user_indexes
where  table_name = 'TICKET_ARCHIVE';

select table_name, num_rows
from   user_tables
where  table_name like 'VECTOR$TICKET_ARCHIVE_IVF%';
