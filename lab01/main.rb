require_relative 'file_comparator'
require_relative 'constants'
require_relative 'stats_persistence_service'
require_relative 'classification_service'
require_relative 'visualisation_service'

class String
  def to_bool
    return true if self =~ (/^(true|t|yes|y|1)$/i)
    return false if self.empty? || self =~ (/^(false|f|no|n|0)$/i)

    raise ArgumentError.new "invalid value: #{self}"
  end
end


def parse_file_name(filePath, extension, file)
  file.match(/#{filePath}(.*)#{extension}/i).captures[0]
end

def analyze(stats)
  goodMatch = Hash.new 0
  wrongMatch = Hash.new 0
  
  stats.each do |n, results_n|
    goodMatch[n] = Hash.new 0
    wrongMatch[n] = Hash.new 0
    
    results_n.each do |testFile, result_file|
      fileLanguage = get_language(testFile)
      
      result_file.each do |method, guessedLang|
	if (fileLanguage == guessedLang)
	  goodMatch[n][method] += 1
	else
	  wrongMatch[n][method] += 1
	end
	
      end
    end
  end
  
  [goodMatch, wrongMatch]
end


statFiles = Dir[$statsPath + "*"]
testFiles = Dir[$testsPath + "*"].map! {|file| parse_file_name($testsPath, ".txt", file)}

results = Hash.new 0
n = 1
until n > ARGV[2].to_i do #change it!!!!
  results[n] = Hash.new 0
  
  testFiles.each do |file|
    results[n][file] = Hash.new 0
    $methods.each do |method|
      results[n][file][method] = parse_file_name($statsPath, "._.*.yml", compare_files($testsPath, file, statFiles, method, n, ARGV[0].to_bool).sort_by { |key, value| value }[0][0])
    end
  end
  n += 1
end

classification = get_classification_stats(results)
matches = analyze(results)

save_classification(classification)
visualize_stats(classification)
save_results(matches)
visualize_matches(matches[0])