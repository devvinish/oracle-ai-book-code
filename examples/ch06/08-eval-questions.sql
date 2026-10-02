-- @setup drop table if exists eval_questions purge
create table eval_questions (
  question_id  number         constraint eval_questions_pk primary key,
  lang         varchar2(2)    default 'en' not null,
  question     varchar2(200)  not null,
  article_id   varchar2(10)   not null constraint eval_questions_article_fk
                                references kb_articles,
  minilm       vector(384, float32),
  gemini       vector(3072, float32)
);

insert into eval_questions (question_id, question, article_id) values
  ( 1, 'I typed my password wrong a few times and now I am locked out', 'KB-101'),
  ( 2, 'The e-mail to reset my password never showed up',                'KB-102'),
  ( 3, 'The codes from my authenticator app are always rejected',        'KB-103'),
  ( 4, 'How can our accountant see invoices without seeing the CRM?',    'KB-104'),
  ( 5, 'I got an alert about a login that was not me',                   'KB-105'),
  ( 6, 'Our card was charged two times for one invoice',                 'KB-201'),
  ( 7, 'Where can I get PDF copies of all our bills?',                   'KB-202'),
  ( 8, 'We are exempt from sales tax but still pay it',                  'KB-203'),
  ( 9, 'What do we pay if we move to a bigger plan mid-month?',          'KB-204'),
  (10, 'Can we print our PO number on the invoice?',                     'KB-205'),
  (11, 'The deals board just spins and never shows anything',            'KB-301'),
  (12, 'After importing a spreadsheet we have the same person twice',    'KB-302'),
  (13, 'The phone app closes right after I open it',                     'KB-401'),
  (14, 'I edited a record on the plane and my change was lost',          'KB-402'),
  (15, 'Our weekly e-mailed report stopped coming',                      'KB-501'),
  (16, 'Revenue in the dashboards does not match the invoice list',      'KB-503'),
  (17, 'Our webhook stopped firing',                                     'KB-601'),
  (18, 'The API keeps answering 429 Too Many Requests',                  'KB-602'),
  (19, 'Meetings do not show up in Outlook',                             'KB-603'),
  (20, 'How do we install the desktop app on 300 laptops?',              'KB-702');

-- questions in Spanish, German, French, and Portuguese
insert into eval_questions (question_id, lang, question, article_id) values
  (21, 'es', 'Nos cobraron dos veces la misma factura',                  'KB-201'),
  (22, 'es', 'La aplicación del móvil se cierra nada más abrirla',       'KB-401'),
  (23, 'de', 'Nach mehreren falschen Passwörtern bin ich gesperrt',      'KB-101'),
  (24, 'de', 'Unser wöchentlicher Bericht kommt nicht mehr per E-Mail',  'KB-501'),
  (25, 'fr', 'Où puis-je télécharger toutes nos factures en PDF ?',      'KB-202'),
  (26, 'fr', 'Notre webhook ne se déclenche plus',                       'KB-601'),
  (27, 'pt', 'Recebi um alerta de um acesso que não fui eu',             'KB-105'),
  (28, 'pt', 'Como instalar o aplicativo em 300 computadores?',          'KB-702');

set timing on
update eval_questions
set    minilm = embed(question, 'MINILM'),
       gemini = embed(question, 'GEMINI');
set timing off
commit;
