def count_n_grams(ngrams)
  counts = Hash.new 0

  ngrams.each do |ngram|
    counts[ngram] += 1
  end
  counts
end
