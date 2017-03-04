require_relative 'yaml_reader'
require 'set'

#return dwo elements array
def get_vectors_from_hashes(hash1, hash2)
  keys = hash1.keys.to_set | hash2.keys.to_set
  
  arr1 = Array.new
  arr2 = Array.new
  
  keys.each do |key|
    arr1 << hash1[key]
    arr2 << hash2[key]
  end
  [arr1, arr2]
end