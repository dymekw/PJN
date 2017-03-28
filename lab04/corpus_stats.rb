require 'yaml'

FILES = ["dramat", "popul", "proza", "publ", "wp"] 
DIR = "lab4/"
EXT = ".txt"

def ommite_line(line)
  line.start_with?("*") || line.empty? || line == "\n"
end

def get_file_stats(fileName)
  result = Hash.new 0
  fileContent = File.read(DIR + fileName + EXT)
  
  fileContent.each_line do |line|
    next if ommite_line(line)
    words = line.downcase.gsub(/[[:punct:]]/, '').split(" ")
    
    words.each do |word|
      result[word] = result[word] + 1
    end
    
  end
  return result
end

def get_corpus_stats()
  fileName = "corpus_stats.yml"
  
  if (File.file?(fileName))
    result = YAML.load(File.read(fileName))
  else
    
    result = Hash.new 0
    
    FILES.each do |file|
      puts "Computing stats for: " + file
      stats = get_file_stats(file)
      
      stats.each do |word, quantity|
	result[word] = result[word] + quantity
      end
    end
    
    result = result.sort_by {|_key, value| value}.to_h
    File.open(fileName, 'w') {|f| f.write result.to_yaml }
  end
  result.default = 0
  return result
end