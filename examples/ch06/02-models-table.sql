-- @setup drop table if exists embedding_models purge
create table embedding_models (
  name        varchar2(30) constraint embedding_models_pk primary key,
  dimensions  number       not null,
  params      json         not null
);

insert into embedding_models values
  ('MINILM', 384,
   json('{"provider": "database", "model": "ALL_MINILM_L12_V2"}')),
  ('GEMINI', 3072,
   json('{"provider": "googleai",
          "credential_name": "GEMINI_CRED",
          "url": "https://generativelanguage.googleapis.com/v1beta/models/",
          "model": "gemini-embedding-001"}'));
commit;

select name, dimensions,
       json_value(params, '$.provider') as provider,
       json_value(params, '$.model')    as model
from   embedding_models;
