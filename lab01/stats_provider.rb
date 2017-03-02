require_relative 'ngram_producer'
require_relative 'ngram_counter'
require_relative 'sentence_parser'
require_relative 'constans'

def get_n_grams_count_for_file(fileName, n, splitIntoWords)
  
  stats = Hash.new 0
  
  text=File.open($path + fileName + $extension, get_encoding(fileName)).read
  text.gsub!(/\r\n?/, "\n")
  
  text.each_line do |line|
    words = parse_sentence(line, splitIntoWords)
    
    words.each do |word|
      stat = count_n_grams(get_n_grams(word, n))
      combine_stats(stats, stat)
    end
  end
  
  stats
end


def combine_stats(globalStats, sentenceStats)
  sentenceStats.each do |s, v|
    globalStats[s] += v
  end
end

def get_encoding(fileName)
  "r:" + $encodings[fileName]
end

def compute_stats(fileName, n, splitIntoWords, sort)
  print "Compute stats for #{fileName}, n = #{n}\n"
  
  result = get_n_grams_count_for_file(fileName, n, splitIntoWords)
  
  length = Math.sqrt(result.values.map {|value| value**2}.inject(0){|sum,x| sum + x })
  result.each{ |key,value| result[key] = value/length }
  
  if (sort)
    result = result.sort_by {|_key, value| value}
  end
  
  print "Finished\n\n"
  result
end