 #!/bin/bash
 splitIntoWords=true
 sort=true
 minNgramValue=0.0
 maxN=5
 
 ruby main_indexer.rb $splitIntoWords $sort $maxN
 ruby main.rb $splitIntoWords $minNgramValue $maxN