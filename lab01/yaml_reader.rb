require 'yaml'

def get_hash_from_file(fileName, minValue=0)
  fileContent = YAML.load(File.read(fileName))
  
  if (fileContent.is_a? Array)
    fileContent = Hash[*fileContent.flatten]
  end
  
  fileContent.default = 0
  fileContent.delete_if {|key, value| value < minValue }
  fileContent
end