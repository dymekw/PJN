TEST_FILE = "lab4/bledy.txt"

def get_test()
  result = Hash.new ""
  fileContent = File.read(TEST_FILE)
  
  fileContent.each_line do |line|
    test = line.strip().downcase()
    
    testSplitted = test.split(';')
    
    result[testSplitted[0]] = testSplitted[1]
  end
  
  return result
end