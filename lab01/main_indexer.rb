require_relative 'stats_provider'
require_relative 'stats_persistence_service'

max_n = 5

#save stats of all files
n = 1
until n > max_n do
  $files.each do |file|
    if (!does_file_exist(n, file))
      result = compute_stats(file, n, true, true)
      save_stats(result, n, file)
    end
  end
  n+=1
end