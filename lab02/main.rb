require_relative "clusters_reader"
require_relative "best_fit_cluster_provider"
require_relative "visualisation_service"

$methods = ["cosine", "dice"]
$maxN = 5


def get_file_name(method, n)
  "results_" + method + "_" + n.to_s + ".yml"
end

clusters = get_clusters()

$methods.each do |method|
  puts method
  stats = Hash.new
  
  for n in 1..5
    puts n
    stats[n] = Hash.new 0
    fileName = get_file_name(method, n)
    myClusters = get_my_clusters(fileName)
    
    macroAverage = 0
    tpSum = 0
    fpSum = 0
    
    puts "Clusters: " + myClusters.size.to_s
    myClusters.each do |cluster|
      matched = get_best_fit_cluster(clusters, cluster)
      quantityOfMatchedMembers = matched[0]
      theBestFitCluster = matched[1]
      
      macroAverage += quantityOfMatchedMembers.to_f / cluster.size.to_f
      tpSum += quantityOfMatchedMembers.to_f
      fpSum += cluster.size.to_f - quantityOfMatchedMembers.to_f
    end
    
    macroAverage = macroAverage / myClusters.size.to_f
    microAverage = tpSum / (tpSum + fpSum)
    
    stats[n]["MACRO"] = macroAverage
    stats[n]["MICRO"] = microAverage
  end
  
  visualize_stats(stats, method)
end