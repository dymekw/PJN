require 'yaml'
require 'gruff'

def get_graph(title, max=1, hide_legend=false)
  g = Gruff::Bar.new('1000x800')
  g.title = title
  g.sort = false
  g.maximum_value = max
  g.minimum_value = 0
  g.theme_37signals
  g.hide_legend = hide_legend
  
  return g
end

def get_dot_graph(title, max=1, hide_legend=false)
  g = Gruff::Dot.new('1000x800')
  g.title = title
  g.sort = false
  g.maximum_value = max
  g.minimum_value = 0
  g.theme_37signals
  g.hide_legend = hide_legend
  
  return g
end

def largest_hash_key(hash)
  hash.max_by{|k,v| v}
end

def get_rank(words)
  rank = Hash.new 0

  words.each do |word|
    rank[word] += 1
  end
  rank.sort_by {|_key, value| value}.to_h
end

def get_digrams(words)
  result = []
  
  for i in 0...words.length-1
    result = result << words[i] + ' ' + words[i+1]
  end
  return result
end

def get_trigrams(words)
  result = []
  
  for i in 0...words.length-2
    result = result << words[i] + ' ' + words[i+1] + ' ' + words[i+2]
  end
  return result
end

def save_hash_to_file(fileName, hash)
  File.open(fileName, "w") {|f| f.write hash.to_yaml }
end

##################################################################

text=File.open("potopTransformed.txt", "r:utf-8").read
words = text.split(' ')

rank = get_rank(words)

save_hash_to_file("rank.yml", rank)

##################################################################

coef = 0.1
max = largest_hash_key(rank)[1]

g = get_graph("Zipf 1", max)
  
rank.each do |word, value|
  next if value.to_f < max.to_f * coef
  g.data(word, value)
end
  
g.write("Zipf 1.png")

##################################################################

g = get_graph("Zipf 2", 50, true)

sum = 0
rank.each do |word, value|
  sum += value
end

per = 0.0
while per < 50
  max = largest_hash_key(rank)
  per += 100 * max[1].to_f / sum
  g.data(max[0], per)
  rank.delete(max[0])
end

g.write("Zipf 2.png")

####################################################################

rank = get_rank(words).sort_by {|_key, value| -value}.to_h

rankHash = Hash.new 0

for i in 0...rank.keys.length
  rankHash[i+1] = rank[rank.keys[i]]
end

save_hash_to_file("rankHash", rankHash)
####################################################################

hapaxLegomena = 0
halfTextMax = 0
halfTextMin = 0

rank = get_rank(words)

rank.each do |word, value|
  if (value == 1)
    hapaxLegomena += 1
  end
end

subSum = 0
rank.sort_by {|_key, value| -value}.each do |pos|
  halfTextMax += 1
  subSum += pos[1]
  if (subSum >= sum/2.0)
    break
  end
end

subSum = 0
rank.sort_by {|_key, value| value}.each do |pos|
  halfTextMin += 1
  subSum += pos[1]
  if (subSum >= sum/2.0)
    break
  end
end

puts "Hapax legomena: " + hapaxLegomena.to_s
puts "50% (max): " + halfTextMax.to_s
puts "50% (min): " + halfTextMin.to_s

################################################################

digrams = get_digrams(words)
trigrams = get_trigrams(words)

save_hash_to_file("digrams.yml", get_rank(digrams))
save_hash_to_file("trigrams.yml", get_rank(trigrams))