require_relative 'tests_provider'
require_relative 'correction_service'
require 'yaml'

class Hash
  def join(keyvaldelim="=", entrydelim=" & ") # $, is the global default delimiter
    map {|e| e.join(keyvaldelim) }.join(entrydelim)
  end
end

def largest_hash_key(hash)
  hash.max_by{|k,v| v}
end

tests = get_test()

wellCorrected1 = Hash.new
wellCorrected2 = Hash.new
wellCorrected3 = Hash.new
noCorrection = Hash.new
wrongCorrection = Hash.new

tests.each do |word, expected|
  puts ""
  @EXCLUDED_PREFIX = "#"
  cor = get_possible_correction(word)
  
  if (cor.keys.size == 0)
    noCorrection[word] = word
    puts "No hint :( Should be: " + expected
  elsif (cor.key?(expected))
    puts "Well corrected: " + cor.join() + " :)"
    max = largest_hash_key(cor)
    
    if (expected == max[0])
      wellCorrected1[word] = max[0]
    else
      cor.delete(max[0])
      max = largest_hash_key(cor)
      if (expected == max[0])
	wellCorrected2[word] = max[0]
      else
	cor.delete(max[0])
	max = largest_hash_key(cor)
	wellCorrected3[word] = max[0]
      end
    end
  else
    wrongCorrection[word] = cor.join()
    puts "Wrong!!! Expected " + expected + " instead of " + cor.join()
  end
  
  if (wellCorrected1.keys.size%10 == 0)
    File.open('good1.yml', 'w') {|f| f.write wellCorrected1.to_yaml }
  end
  if (wellCorrected2.keys.size%10 == 0)
    File.open('good2.yml', 'w') {|f| f.write wellCorrected2.to_yaml }
  end
  if (wellCorrected3.keys.size%10 == 0)
    File.open('good3.yml', 'w') {|f| f.write wellCorrected3.to_yaml }
  end
  if (noCorrection.keys.size%10 == 0)
    File.open('no.yml', 'w') {|f| f.write noCorrection.to_yaml }
  end
  if (wrongCorrection.keys.size%10 == 0)
    File.open('wrong.yml', 'w') {|f| f.write wrongCorrection.to_yaml }
  end
end


File.open('good1.yml', 'w') {|f| f.write wellCorrected1.to_yaml }
File.open('good2.yml', 'w') {|f| f.write wellCorrected2.to_yaml }
File.open('good3.yml', 'w') {|f| f.write wellCorrected3.to_yaml }
File.open('no.yml', 'w') {|f| f.write noCorrection.to_yaml }
File.open('wrong.yml', 'w') {|f| f.write wrongCorrection.to_yaml }