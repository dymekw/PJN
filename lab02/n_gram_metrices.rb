require 'set'

def min (a,b)
  a>b ? b : a
end

def get_dice(ngramsX, ngramsY)
  intersection = ngramsX.keys.to_set & ngramsY.keys.to_set
  
  nominator = 0
  intersection.each do |commonKey|
    nominator += min(ngramsX[commonKey], ngramsY[commonKey])
  end
  nominator *= 2
  
  denominator = 0
  ngramsX.each do |key, value|
    denominator += value
  end
  ngramsY.each do |key, value|
    denominator += value
  end
  
  return 1 - (nominator.to_f / denominator.to_f)
end

def longest_common_substr(s1, s2)
    return "" if s1 == "" || s2 == ""
  
    m = Array.new(s1.length){ [0] * s2.length }
    longest_length, longest_end_pos = 0,0
    (0 .. s1.length - 1).each do |x|
      (0 .. s2.length - 1).each do |y|
        if s1[x] == s2[y]
          m[x][y] = 1
          if (x > 0 && y > 0)
            m[x][y] += m[x-1][y-1]
          end
          if m[x][y] > longest_length
            longest_length = m[x][y]
            longest_end_pos = x
          end
        end
      end
    end
    return s1[longest_end_pos - longest_length + 1 .. longest_end_pos]
  end