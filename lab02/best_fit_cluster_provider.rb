def get_best_fit_cluster(clusters, myCluster)
  theBestCluster=[]
  maxMatchedMembers = 0
  
  clusters.each do |cluster|
    matchedInCluster = 0
    cluster.each do |member|
      if (myCluster.include? member)
	matchedInCluster += 1
      end
    end 
    
    if (matchedInCluster > maxMatchedMembers) || (matchedInCluster == maxMatchedMembers && theBestCluster.size > cluster.size)
      theBestCluster = cluster
      maxMatchedMembers = matchedInCluster
    end
    
  end
  
  return [maxMatchedMembers, theBestCluster]
end