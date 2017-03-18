#!/usr/bin/env python
#-*- coding: utf-8 -*-

from plp import *
import sys
import os.path
import re
import codecs
import unicodedata
import string


def transformWord(word):
	validWord = word
	for c in string.punctuation:
		validWord = validWord.replace(c,"")
	validWord = validWord.lower().encode('UTF-8')

	if not plp_rec(validWord):
		return validWord
	for id in plp_rec(validWord):
		return plp_bform(id)
	return validWord

def transformLine(line):
	words = line.split()
	transformedWords = []
	
	for word in words:
		transformedWords.append(transformWord(word))

	result = ""
	for word in transformedWords:
		try:
			convertedWord = word.decode('utf-8')
		except:
			print "Error in: " + word
			convertedWord = word
		result = result + convertedWord + " "
	return result

fileName = "potopTransformed.txt"
textFile = "potop.txt"

plp_init()

if not os.path.isfile(fileName):
	print ("Brak pliku")
	with codecs.open(textFile, 'r', encoding="utf-8") as f:
		content = f.readlines()

	file = codecs.open(fileName,"w", encoding="utf-8-sig")
	
	for line in content:
		if line.isspace():
			continue
		file.write(transformLine(line))
	
	
	file.close()
else:
	print ("Mamy plik")