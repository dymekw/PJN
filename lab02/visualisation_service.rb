require 'gruff'

def visualize_stats(stats, method)
        
  data = Hash.new
  
  data["MACRO"] = []
  data["MICRO"] = []
  
  stats.each do |n, nStats|
    nStats.each do |metric, value|
      data[metric] = data[metric] << value
    end
  end
  
  puts data
  
  labels = Hash.new ""
      
  stats.each do |n, nStats|
    labels[n-1] = n.to_s
  end
  
  g = get_graph(method)
  data.each do |stat, value|
    g.data(stat, value)
  end
      
  g.labels = labels 
  g.write(method + ".png")
      
end


def get_graph(title, max=1)
  g = Gruff::Bar.new('800x500')
  g.title = title
  g.sort = false
  g.maximum_value = max
  g.minimum_value = 0
  g.theme_37signals
  
  return g
end