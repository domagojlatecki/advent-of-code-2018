var lines: seq[string] = @[]

for line in stdin.lines:
  lines.add(line)

proc distance(a: string, b: string): int =
  var dist = 0

  for i in 0..<a.len:
    if a[i] != b[i]:
      dist += 1

  dist

proc getSameChars(a: string, b: string): string =
  var str = ""
  
  for i in 0..<a.len:
    if a[i] == b[i]:
      str.add(a[i])

  str

block outer:
  for first in lines:
    for second in lines:
      if distance(first, second) == 1:
        echo getSameChars(first, second)
        break outer
