 #!/bin/bash
 splitIntoWords=false
 sort=false
 minNgramValue=0.01
 maxN=7
 
 ruby main_indexer.rb $splitIntoWords $sort $maxN
 ruby main.rb $splitIntoWords $minNgramValue $maxN