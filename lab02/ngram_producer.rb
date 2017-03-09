def get_n_grams(word, n)
  word.downcase.split("").each_cons(n).to_a.map!{|ngram| concat_array(ngram)}
end

def concat_array(array)
  array.join("")
end