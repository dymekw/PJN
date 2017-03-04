require_relative 'stats_provider'
require_relative 'stats_persistence_service'
require_relative 'constants'

class String
  def to_bool
    return true if self =~ (/^(true|t|yes|y|1)$/i)
    return false if self.empty? || self =~ (/^(false|f|no|n|0)$/i)

    raise ArgumentError.new "invalid value: #{self}"
  end
end

max_n = ARGV[2].to_i

#save stats of all files
n = 1
indexerThreads=[]
until n > max_n do
  $files.each do |file|
    if (!does_file_exist(n, file))
      result = compute_stats($path, file, n, ARGV[0].to_bool, ARGV[1].to_bool)
      save_stats(result, n, file)
    end
  end
  n+=1
end
indexerThreads.map(&:join)