'''
Without Using Modules
'''

special_chars = []
counter = {}

for char in range (32,127):
    if (char>32 and char<=47) or (char>=58 and char<=64) or (char>=91 and char<=96) or (char>=123 and char<=126):
        special_chars.append(chr(char))

file = open("sample-paragraph.txt")
paragraph = str(file.read())

for char in special_chars:
    counter[char] = paragraph.count(char)

for key, value in counter.items():
    print('{key} = {value}'.format(key=key, value=value));

#--------------------------------------------------------------------#

'''
Using Modules
'''

from string import punctuation
from collections import Counter

special_chars = list(punctuation)

file = open("sample-paragraph.txt")
paragraph = str(file.read())
counter = Counter(paragraph)

for char in special_chars:
     print('{key} = {value}'.format(key=char, value=counter[char]));
