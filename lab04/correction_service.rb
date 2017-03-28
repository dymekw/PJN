require_relative "form_provider"
require_relative "probability_provider"
require_relative "corpus_stats"

@FORMS = nil
@CORPUS = nil
@SUM = 0

def get_possible_correction(word)
  if (@FORMS.nil?)
    @FORMS = get_forms()
  end
  
  if (@CORPUS.nil?)
    @CORPUS = get_corpus_stats()

    @CORPUS.each do |word, quantity|
      @SUM += quantity
    end
  end
  
  corrections = Hash.new 0
  minInHash = 0
  
  puts "Word: " + word
  @FORMS.each_with_index do |form, index|  
    next if form.start_with?(@EXCLUDED_PREFIX)
    
    p = PROBABILITY(word, form, @SUM, @CORPUS)
    if (p > minInHash)
      corrections[form] = p
      
      if (corrections.keys.size >= 4)
	minKey = corrections.sort_by { |key, value| value }.first[0]
	corrections.delete(minKey)
      end
      
      minInHash = corrections.sort_by { |key, value| value }.first[1]
    end
  end
  
  return corrections
end