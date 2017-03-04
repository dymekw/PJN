require 'yaml'
require 'json'
require 'set'
require_relative 'constants'

def save_results(stats)
  set = Set.new
  
  stats[0].each do |n, result|
    set = set | result.keys.to_set
  end
  
  stats[1].each do |n, result|
    set = set | result.keys.to_set
  end
  
  string = ""
  stats[0].each do |n, result_n|
    string += n.to_s
    set.each do |method|
      string += "," 
      string += method
      string += "," 
      string += result_n[method].to_s
    end
    string += "\n"
  end
  print string
  
  string += "\n\n\n"
  stats[1].each do |n, result_n|
    string += n.to_s
    set.each do |method|
      string += "," 
      string += method
      string += "," 
      string += result_n[method].to_s
    end
    string += "\n"
  end
  
  File.open("matches.csv", "w") {|f| f.write string }
end

def save_stats(stats, n, fileName)
  File.open($statsPath + get_file_name(n, fileName), "w") {|f| f.write stats.to_yaml }
end

def does_file_exist(n, fileName)
  File.exist?($statsPath + get_file_name(n, fileName))
end

def get_file_name(n, fileName)
  fileName + "_" + n.to_s + ".yml"
end