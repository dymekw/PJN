
def process_line(line)
  
   #downcase
   result = line.downcase
   
   #space instead of some symbols
   result = result.gsub(/[:]/i, ' ')
   
   #remove non alphanumeric symbols
   result = result.gsub(/[^0-9a-z ]/i, '')
   3result = result.gsub(/[^a-z ]/i, '')
   
   return result
 end