require 'gruff'
require_relative 'constants'

def visualize_stats(stats)
  $languages.each do |language|
    $classificators.each do |classificator|
      
      g = get_graph(language + " " + classificator)
      data = Hash.new
      
      $methods.each do |method|
	data[method] = []
      end
      
      stats.each do |n, nStats|
	nStats.each do |method, methodStats|
	  data[method] = data[method] << methodStats[language][classificator]
	end
      end
      
      data.each do |stat, value|
	g.data(stat, value)
      end
      
      labels = Hash.new ""
      
      stats.each do |n, nStats|
	labels[n-1] = n.to_s
      end

      g.labels = labels
      
      print "Saving: " + language + " " + classificator + "\n"
      g.write($resultsPath + language + "_" + classificator + ".png")
      
    end
  end
end

def visualize_matches(matches)
  
  data = Hash.new
  
  $methods.each do |method|
    data[method] = []
  end
  
  max = 0
  matches.each do |n, result_n|
    $methods.each do |method|
      if (result_n[method] > max)
	max = result_n[method]
      end
      data[method] = data[method] << result_n[method]
    end
  end
  
  g = get_graph("matches", max)
  
  labels = Hash.new ""
      
  matches.each do |n, nStats|
    labels[n-1] = n.to_s
  end
  g.labels = labels
  
  data.each do |stat, value|
    g.data(stat, value)
  end
  
  g.write($resultsPath + "matches.png")
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