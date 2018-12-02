import tables

var twoRepeatedChars = 0
var threeRepeatedChars = 0

for line in stdin.lines:
  var charCounts = initCountTable[char]()

  for c in line.items:
    charCounts.inc(c)

  var inc2 = false
  var inc3 = false

  for count in charCounts.values:
    if count == 2 and not inc2:
      twoRepeatedChars += 1
      inc2 = true
    elif count == 3 and not inc3:
      threeRepeatedChars += 1
      inc3 = true

echo twoRepeatedChars * threeRepeatedChars
