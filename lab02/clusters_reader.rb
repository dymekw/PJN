require 'yaml'

def get_clusters()
  fileContent = File.read("data/clusters.txt")
  
  clusters = []
  currentCluster = []
  
  fileContent.each_line do |line|
    next if line == "\n"
    if (line.include? "##########")
      clusters = clusters << currentCluster
      currentCluster = []
    else
      currentCluster = currentCluster << line
    end
  end
  
  return clusters
end

def get_my_clusters(fileName)
  fileContent = YAML.load(File.read(fileName))
  
  if (fileContent.is_a? Array)
    fileContent = Hash[*fileContent.flatten]
  end
  
  fileContent.default = 0
  fileContent.values
end