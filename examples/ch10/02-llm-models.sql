-- @setup drop table if exists llm_models purge
create table llm_models (
  name      varchar2(30) constraint llm_models_pk primary key,
  params    json         not null,
  thinking  varchar2(3)  default 'Yes' not null  -- accepts thinking settings
);

insert into llm_models (name, params, thinking) values
  ('GEMINI',
   json('{"provider": "googleai",
          "credential_name": "GEMINI_CRED",
          "url": "https://generativelanguage.googleapis.com/v1beta/models/",
          "model": "gemini-flash-latest:generateContent"}'), 'Yes'),
  ('GEMINI_LITE',
   json('{"provider": "googleai",
          "credential_name": "GEMINI_CRED",
          "url": "https://generativelanguage.googleapis.com/v1beta/models/",
          "model": "gemini-flash-lite-latest:generateContent"}'), 'No');
commit;

select name, json_value(params, '$.model') as model, thinking from llm_models;
