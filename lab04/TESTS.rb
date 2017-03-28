require_relative "Levenshtein"
require_relative "probability_provider"
require_relative "corpus_stats"
require_relative "correction_service"

def assert(expected, actual, msg=nil)
  if (expected != actual)
    puts "TEST FAILED!!!"
    puts "Expected: " + expected.to_s + ", actual: " + actual.to_s
    
    unless msg.nil?
      puts msg
    end
    exit 1
  else
    puts "TEST OK"
  end
end

assert(2.5,	LEVENSHTEIN("biurko", "pióro"))
assert(1, 	LEVENSHTEIN("ćwiek", "dźwiek"))
assert(1.5, 	LEVENSHTEIN("ćwiek", "dźwięk"))
assert(0.5, 	LEVENSHTEIN("hażać", "hażąć"))
assert(1.5, 	LEVENSHTEIN("hażać", "hażądź"))
assert(2.5, 	LEVENSHTEIN("hażać", "chażądź"))
assert(3.5, 	LEVENSHTEIN("hażać", "charządź", 10))
assert(0, 	LEVENSHTEIN("biurko", "biurko"))
assert(6, 	LEVENSHTEIN("", "biurko", 10))
assert(1.5, 	LEVENSHTEIN("bądź", "bać"))
assert(2, 	LEVENSHTEIN("na", "bać"))
assert("bądź",	get_possible_correction("bać"))

puts get_conditional_probability("biurko", "biuro")
puts LEVENSHTEIN("ardeko", "art deco")

stats = get_corpus_stats()
sum = 0

stats.each do |word, quantity|
  sum += quantity
end

puts get_correction_probability("w", sum, stats)