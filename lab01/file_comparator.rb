require_relative 'yaml_reader'
require_relative 'stats_provider'
require_relative 'vector_mapper'
require_relative 'vector_distance_service'

# path - where fileToGuess is
# fileToGuess - path to file with some text in unknow lang
# filesWithStats - files with n-gram stats
# method - euclidean / manhattan / maximum / cosine
# n - n-gram
# @returns hash [fileWithStats => similarity]

$uploadedStats = Hash.new 0

def compare_files(path, fileToGuess, filesWithStats, method, n, splitIntoWords)
  statistics = Hash.new 0
  testsStats = compute_stats(path, fileToGuess, n, splitIntoWords, false)
  
  filesWithStats.each do |fileWithStats|
    unless ((/.*_#{n}.yml/ =~ fileWithStats).nil?)
      print "Compare #{fileToGuess} with #{fileWithStats}...\n"
      stats = $uploadedStats[fileWithStats]
      
      if (stats.is_a? Numeric)
	stats = get_hash_from_file(fileWithStats, ARGV[1].to_f)
	$uploadedStats[fileWithStats] = stats
      end
      
      vectors = get_vectors_from_hashes(stats, testsStats)
      
      result = 0
      if (method == "euclidean")
	result = get_euclidean_distance(vectors[0], vectors[1])
      elsif (method == "manhattan")
	result = get_manhattan_distance(vectors[0], vectors[1])
      elsif (method == "maximum")
	result = get_maximum_distance(vectors[0], vectors[1])
      elsif (method == "cosine")
	result = get_cosine_distance(vectors[0], vectors[1])
      else
	print "Unknown method to compute distance!!!"
      end
      
      statistics[fileWithStats] = result
    end
  end

  statistics
end