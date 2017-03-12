require_relative 'line_stats_producer'
require_relative 'n_gram_metrices'
require 'yaml'

text=File.open("data/lines.txt").read
methods = ["dice", "cosine"]
$maxValue = {"dice" => 0.1, "cosine" => 0.05}
$countRepatition = false

def does_file_exist(fileName)
  File.exist?(fileName)
end

def is_close_neighbour(value, method)
    value <= $maxValue[method]
end

def normalize(stats)
  stats.each do |line, ngramStats|
    sum = 0
    ngramStats.each do |ngram, value|
      sum += value
    end
    coef = Math.sqrt(sum)
    stats[line] = ngramStats.map{|ngram, value| [ngram, value/coef.to_f]}.to_h
  end
end

def get_clusters(stats, method)
  clusters = Hash.new
  maxCluster = 0

  for i in 0...stats.keys.size
    if (i%100 == 0)
      print i.to_s + "\t"
    end
    addedToCluster=false
    
    for j in 0...maxCluster
      clusters.each do |clusterName, members|
	  next if members.size <= j
	  
	  if (method == "dice")
	    if ($countRepatition)
	      result = get_dice(stats[stats.keys[i]], stats[members[j]])
	    else
	      result = get_dice_without_rep(stats[stats.keys[i]], stats[members[j]])
	    end
	  elsif (method == "cosine")
	    result = get_cosine(stats[stats.keys[i]], stats[members[j]])
	  end

	  if (is_close_neighbour(result, method))	#i'm sure that this is cluster member
	    members = members << stats.keys[i]
	    addedToCluster = true
	    if (members.size > maxCluster)
	      maxCluster = members.size
	    end
	    break
	  end
      end
      if (addedToCluster)
	break
      end
    end
    if (!addedToCluster)
      clusters[stats.keys[i]] = [stats.keys[i]]
      if (clusters[stats.keys[i]].size > maxCluster)
	maxCluster = clusters[stats.keys[i]].size
      end
    end
  end
  
  return clusters
end

methods.each do |method|
  puts "METHOD: " + method
  for n in 1..5
    puts "\tN: " + n.to_s
    next if does_file_exist("results_" + method + "_" + n.to_s + ".yml")
    stats = Hash.new 0
    
    if (method == "dice")
      text.each_line do |line|
	stats[line] =  get_line_ngram_set(line, n, $countRepatition)
      end
    elsif (method == "cosine")
      text.each_line do |line|
	stats[line] =  get_line_ngram_set(line, n, true)
      end
      stats = normalize(stats)
    end
    
    clusters = get_clusters(stats, method)
    #clusters.each do |clusterName, members|
    #  puts clusterName
    #  members.each do |member|
    #	puts "\t" + member
    #  end
    #  puts "\n"
    #end
    File.open("results_" + method + "_" + n.to_s + ".yml", "w") {|f| f.write clusters.to_yaml }
  end
end