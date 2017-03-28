require 'set'

@EXCLUDED_PREFIX = "#"

#weight = 0.5
PARTIALLY = [['o', 'ó'], 
	     ['ó', 'u'], 
	     ['a', 'ą'], 
	     ['e', 'ę'], 
	     ['c', 'ć'], 
	     ['z', 'ż'],
             ['u', 'ł'],
             ['l', 'ł'],
             ['p', 'b']
             ]

#weight = 1
DOUBLES = {'ć' => "dź",
           'ż' => "rz",
           'h' => "ch",
           'ł' => "au",
           'ę' => "en",
           'ą' => "om"
           }

def max (a,b)
  a>b ? a : b
end

def min (a,b)
  a>b ? b : a
end

# aStr - string with some mistakes
# bStr - string from forms
# a - current iter position in aStr
# b - current iter position in bStr
# @return 0-if equal 1-if not (0,1) - partially
def areCharsEquals(aStr, bStr, a, b)
  if (aStr[a-1] == bStr[b-1])
    return 0
  end
  
  DOUBLES.each do |char, double|
    if (aStr[a-1] == char)
      if ((bStr.include? double) && (bStr.index(double) == b-1))
	return 0
      end
    elsif (bStr[b-1] == char)
      if ((aStr.include? double) && (aStr.index(double) == a-1))
	return 0
      end
    end
  end
    
  PARTIALLY.each do |item|
    if ((item.include? aStr[a-1]) && (item.include? bStr[b-1]))
      return 0.5
    end
  end
  
  return 1
end

def get_distance(aStr, bStr, maxDistance)
  a = aStr.length
  b = bStr.length
  
  levTable = Hash.new -1
  for i in 0..a
    levTable[[i, 0]] = i
  end
  
  for j in 0..b
    levTable[[0, j]] = j
  end
  
  for j in 1..b
    minInRow = max(a, b)
    
    for i in 1..a
      lev_3 = levTable[[i-1,j-1]]
      lev_3 += areCharsEquals(aStr, bStr, i, j)
      
      levTable[[i, j]] = min(min(levTable[[i-1, j]], levTable[[i, j-1]]) + 1, lev_3)
      
      if (minInRow > levTable[[i, j]])
	minInRow = levTable[[i, j]]
      end
    end
    
    if (minInRow >= maxDistance)
      @EXCLUDED_PREFIX = bStr[0...j]
      return maxDistance
    end
  end

  return levTable[[a, b]]
end

def LEVENSHTEIN(a,b, maxDistance=3)
  get_distance(a,b, maxDistance)
end