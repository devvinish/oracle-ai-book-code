-- @setup drop table if exists doc_chunks purge
-- @setup drop table if exists atlas_documents purge
create table atlas_documents (
  doc_id      number generated always as identity constraint atlas_documents_pk primary key,
  file_name   varchar2(200) not null constraint atlas_documents_file_uk unique,
  doc_type    varchar2(20)  not null,
  title       varchar2(200) not null,
  product_id  number        constraint atlas_documents_product_fk references products,
  content     blob          not null,
  loaded_on   date          default sysdate not null
);

insert into atlas_documents (file_name, doc_type, title, product_id, content)
with files (file_name, doc_type, title, product_id) as (
  values ('atlas-crm-admin-guide.pdf', 'Manual', 'Atlas CRM 8.4 Administrator Guide', 1),
         ('atlas-billing-user-guide.pdf', 'Manual', 'Atlas Billing 5.2 User Guide', 2),
         ('atlas-mobile-guide.pdf', 'Manual', 'Atlas Mobile 3.9 Guide', 3),
         ('atlas-connect-api-faq.docx', 'FAQ', 'Atlas Connect API FAQ', 5),
         ('atlas-sync-faq.docx', 'FAQ', 'Atlas Sync FAQ', 6),
         ('atlas-crm-8.4.1-release-notes.html', 'Release notes', 'Atlas CRM 8.4.1', 1),
         ('atlas-mobile-3.9.1-release-notes.html', 'Release notes',
          'Atlas Mobile 3.9.1', 3),
         ('atlas-analytics-6.1-release-notes.html', 'Release notes',
          'Atlas Analytics 6.1', 4))
select file_name, doc_type, title, product_id, to_blob(bfilename('ATLAS_FILES', file_name))
from   files;
commit;

select doc_id, file_name, doc_type, dbms_lob.getlength(content) as bytes
from   atlas_documents
order  by doc_id;
