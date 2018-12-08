# Advent of Code 2018

Advent of code 2018 task solutions.

### Run
Day 1 - Task 1: `cat data/Day1.txt | xargs clj src/Day1Task1.clj`  
Day 1 - Task 2: `cat data/Day1.txt | xargs clj src/Day1Task2.clj`  
Day 2 - Task 1: `nim c -r src/Day2Task1.nim < data/Day2.txt; rm -f src/Day2Task1`  
Day 2 - Task 2: `nim c -r src/Day2Task2.nim < data/Day2.txt; rm -f src/Day2Task2`  
Day 3 - Task 1: `fsharpc src/Day3Task1.fs; mono Day3Task1.exe < data/Day3.txt; rm -f Day3Task1.exe FSharp.Core.dll`  
Day 3 - Task 2: `fsharpc src/Day3Task2.fs; mono Day3Task2.exe < data/Day3.txt; rm -f Day3Task2.exe FSharp.Core.dll`  
Day 4 - Task 1: `csc src/Day4Task1.cs; mono Day4Task1.exe < data/Day4.txt; rm -f Day4Task1.exe`  
Day 4 - Task 2: `csc src/Day4Task2.cs; mono Day4Task2.exe < data/Day4.txt; rm -f Day4Task2.exe`  
Day 5 - Task 1: `swiftc src/Day5Task1.swift; ./Day5Task1 < data/Day5.txt; rm -f Day5Task1`  
Day 5 - Task 2: `swiftc src/Day5Task2.swift; ./Day5Task2 < data/Day5.txt; rm -f Day5Task2`  
Day 6 - Task 1: `cat data/Day6.txt | xargs -d '\n' node src/Day6Task1.js`  
Day 6 - Task 2: `cat data/Day6.txt | xargs -d '\n' node src/Day6Task2.js`  
Day 7 - Task 1: `python3 src/Day7Task1.py data/Day7.txt`  
Day 7 - Task 2: `python3 src/Day7Task2.py data/Day7.txt`  
Day 8 - Task 1: `gcc src/Day8Task1.c; cat data/Day8.txt | xargs ./a.out; rm -f a.out`  

### Versions
clj 1.9.0  
nim 0.19.0  
fsharpc 4.1  
mono 5.14.0.177  
csc 2.7.0.62620  
swiftc 4.2.1  
node 10.12.0  
python3 3.7.0  
gcc 4.2.1  
