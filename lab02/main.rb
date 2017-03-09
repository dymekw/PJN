require_relative 'line_stats_producer'
require_relative 'n_gram_metrices'
require 'yaml'

def is_close_neighbour(value)
  value <= 0.2
end

def is_close_enough_neighbour(value)
  value <= 0.4
end

text=File.open("data/lines.txt").read
countRepatition = false

stats = Hash.new 0
text.each_line do |line|
  stats[line] =  get_line_ngram_set(line, 2, countRepatition)
end

min = 1
minLine1=""
minLine2=""


clusters = Hash.new

for i in 0...stats.keys.size
  puts i.to_s + " " + stats.keys[i]
  addedToCluster=false
  
  clusters.each do |clusterName, members|
    members.each do |member|
      result = get_dice(stats[stats.keys[i]], stats[member])
     
      #debug#####
      if (result < min)
	minLine1 = stats.keys[i]
	minLine2 = member
	min = result
      end
      ###########
      
      if (is_close_neighbour(result))	#i'm sure that this is cluster member
	members = members << stats.keys[i]
	addedToCluster = true
	break
      end
      
      next if is_close_enough_neighbour(result)	#maybe it's cluster member but need to check
	
      break #far away from one of members

    end
    if (addedToCluster)
      break
    end
  end
  
  if (!addedToCluster)
    clusters[stats.keys[i]] = [stats.keys[i]]
  end
end

#File.open("results.txt", "w") {|f| f.write clusters.to_yaml }


clusters.each do |clusterName, members|
  puts clusterName
  members.each do |member|
    puts "\t" + member
  end
  puts "\n"
end
puts "Min value: " + min.to_s
puts minLine1
puts minLine2