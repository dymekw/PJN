require_relative "Levenshtein"

MAX_DISTANCE = 3

def get_correction_probability(correction, n, stats)
  if (stats[correction].nil?)
    puts "Nil for: " + correction
  end
  return (stats[correction] + 1).to_f / (n + 1).to_f
end

def get_conditional_probability(word, correction)
  return max(0, (MAX_DISTANCE - LEVENSHTEIN(word, correction)).to_f / MAX_DISTANCE)
end

def PROBABILITY(word, correction, n, stats)
  conditional = get_conditional_probability(word, correction)
  
  if (conditional == 0)
    return 0
  end
  
  return conditional * get_correction_probability(correction, n, stats)
end