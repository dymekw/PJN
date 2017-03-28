require_relative "corpus_stats"
require_relative 'tests_provider'

def get_forms()
  result = []
  fileContent = File.read(DIR + "formy" + EXT)
  
  fileContent.each_line do |line|
    result = result << line.strip().downcase()
  end
  
  tests = get_test()
  
  tests.each do |word, correction|
    result = result << correction.strip().downcase()
  end
  result.sort_by!{ |m| m.downcase }

  return result
end