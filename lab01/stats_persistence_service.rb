require 'yaml'

def save_stats(stats, n, fileName)
  File.open("stats/" + get_file_name(n, fileName), "w") {|f| f.write stats.to_yaml }
end

def does_file_exist(n, fileName)
  File.exist?("stats/" + get_file_name(n, fileName))
end

def get_file_name(n, fileName)
  fileName + "_" + n.to_s + ".yml"
end