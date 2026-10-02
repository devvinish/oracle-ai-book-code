select dbms_vector_chain.utl_to_summary(
         (select dbms_vector_chain.utl_to_text(content)
          from   atlas_documents
          where  file_name = 'atlas-mobile-guide.pdf'),
         (select json_mergepatch(params,
                   '{"systemInstruction": {"parts": [{"text":
                     "Summarize in three plain-text sentences, without Markdown."}]}}'
                   returning json)
          from   llm_models
          where  name = 'GEMINI')) as summary
from   dual;
