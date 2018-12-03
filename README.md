# Advent of Code 2018

Advent of code 2018 task solutions.

### Run
Day 1 - task 1: `cat data/Day1.txt | xargs clj src/Day1Task1.clj`  
Day 1 - task 2: `cat data/Day1.txt | xargs clj src/Day1Task2.clj`  
Day 2 - task 1: `nim c -r src/Day2Task1.nim < data/Day2.txt; rm -f src/Day2Task1`  
Day 2 - task 2: `nim c -r src/Day2Task2.nim < data/Day2.txt; rm -f src/Day2Task2`  
Day 3 - task 1: `fsharpc src/Day3Task1.fs; mono Day3Task1.exe < data/Day3.txt; rm -f Day3Task1.exe FSharp.Core.dll`  
Day 3 - task 2: `fsharpc src/Day3Task2.fs; mono Day3Task2.exe < data/Day3.txt; rm -f Day3Task2.exe FSharp.Core.dll`  

### Versions
clj 1.9.0  
nim 0.19.0  
fsharpc 4.1  
mono 5.14.0.177  
