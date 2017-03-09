require_relative 'preprocessing_service'
require_relative 'ngram_producer'

def get_line_stats(line, n)
  processedLine = process_line(line)
  words = processedLine.split(' ')
  result = Hash.new 0
  words.map{|word| result[word] =  get_n_grams(word, n)}
  return result
end

def get_line_ngram_set(line, n, countRepetition)
  stats = get_line_stats(line, n)
  result = Hash.new 0
  
  stats.each do |word, ngrams|
    if ngrams.empty?
      result[word] += 1
    else
      ngrams.each do |ngram|
	result[ngram] += 1
      end
    end
  end
  
  if (!countRepetition)
    result.each do |x,y|
      result[x] = 1
    end
  end
  
  return result
end