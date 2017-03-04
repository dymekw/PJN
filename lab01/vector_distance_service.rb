def get_euclidean_distance(v1, v2)
  sum = 0
  v1.zip(v2).each do |v1e, v2e|
    sum += (v1e - v2e)**2
  end
  Math.sqrt(sum)
end

def get_manhattan_distance(v1, v2)
  sum = 0
  v1.zip(v2).each do |v1e, v2e|
    sum += (v1e - v2e).abs
  end
  sum
end

def get_maximum_distance(v1, v2)
  max = 0
  v1.zip(v2).each do |v1e, v2e|
    diff = (v1e - v2e).abs
    if (diff > max)
      max = diff
    end
  end
  max
end

def get_cosine_distance(v1, v2)
  sum = 0
  v1.zip(v2).each do |v1e, v2e|
    sum += (v1e * v2e)
  end
  
  (1 -(sum/(vector_length(v1) * vector_length(v2))))
end

def vector_length(v)
  sum = 0
  v.each do |ve|
    sum += ve**2
  end
  Math.sqrt(sum)
end