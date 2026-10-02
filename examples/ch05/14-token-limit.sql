-- two texts that differ only in their last words, after 100 and after 300 words of filler
with filler (words, text) as (
  values (100, rpad('apple ', 600, 'apple ')),
         (300, rpad('apple ', 1800, 'apple ')))
select words as filler_words,
       round(vector_distance(
         vector_embedding(all_minilm_l12_v2
                          using text || 'my invoice was wrong' as data),
         vector_embedding(all_minilm_l12_v2
                          using text || 'the app crashes on start' as data),
         cosine), 4) as distance
from   filler;
