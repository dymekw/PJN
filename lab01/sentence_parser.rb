def parse_sentence(sentence, splitIntoWords)
  if (splitIntoWords)
    result = sentence.tr('^A-Za-z ', '').split(' ')
  else
    result = [sentence.tr('^A-Za-z ', '')]
  end
  
  result
end