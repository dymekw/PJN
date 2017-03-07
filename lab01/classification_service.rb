require_relative 'constants'

def get_classification_stats(stats)
  quantityOfTestingFiles = Dir[$testsPath + "*"].length
  allMethods = $methods
  allLanguages = $languages
  filesPerLanguage = quantityOfTestingFiles / allLanguages.length
  result = Hash.new 0
  
  stats.each do |n, nStats|
    result[n] = Hash.new 0
    
    allMethods.each do |method|
      result[n][method] = Hash.new 0
      
      allLanguages.each do |language|
	result[n][method][language] = Hash.new 0
	qualifiedFiles = []
	
	nStats.each do |file, methods|
	  if (methods[method] == language)
	    qualifiedFiles << file
	  end
	end
	
	truePositives = 0
	qualifiedFiles.each do |file|
	  if (get_language(file) == language)
	    truePositives += 1
	  end
	end
	falsePositives = qualifiedFiles.length - truePositives
	falseNegatives = filesPerLanguage - truePositives
	trueNegatives = quantityOfTestingFiles - filesPerLanguage - falsePositives
	
	precision = truePositives.to_f / (truePositives+falsePositives)
	recall = truePositives.to_f / (truePositives+falseNegatives)
	result[n][method][language]["precision"] = precision
	result[n][method][language]["recall"] = recall
	result[n][method][language]["f1"] = 2 * (precision*recall) / (precision+recall)
	result[n][method][language]["accuracy"] = (truePositives.to_f+trueNegatives.to_f)/(quantityOfTestingFiles)
      end
    end
  end
  
  result
end

def get_language(fileName)
  fileName.match(/(.*)\d/i).captures[0]
end