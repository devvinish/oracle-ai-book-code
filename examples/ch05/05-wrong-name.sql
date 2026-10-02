-- @expect-error
select vector_embedding(all_minilm_l12_v2 using 'I cannot sign in' as text) from dual;

select vector_embedding(minilm using 'I cannot sign in' as data) from dual;
