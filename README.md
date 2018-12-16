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
Day 8 - Task 2: `gcc src/Day8Task2.c; cat data/Day8.txt | xargs ./a.out; rm -f a.out`  
Day 9 - Task 1: `javac src/Day9Task1.java; cat data/Day9.txt | xargs -0 java -cp src Day9Task1; rm -f src/Day9Task1.class`  
Day 9 - Task 2: `javac src/Day9Task2.java; cat data/Day9.txt | xargs -0 java -cp src Day9Task2; rm -f src/Day9Task2*.class`  
Day 10 - Task 1: `bash src/Day10Task1.sh data/Day10.txt`  
Day 10 - Task 2: `bash src/Day10Task2.sh data/Day10.txt`  
Day 11 - Task 1: `erlc src/Day11Task1.erl; num=$(cat data/Day11.txt); erl -noshell -s Day11Task1 main $num -s init stop; rm -f Day11Task1.beam`  
Day 11 - Task 2: `erlc src/Day11Task2.erl; num=$(cat data/Day11.txt); erl -noshell -s Day11Task2 main $num -s init stop; rm -f Day11Task2.beam`  
Day 12 - Task 1: `cat data/Day12.txt | xargs -d '\n' ts-node src/Day12Task1.ts`  
Day 12 - Task 2: `cat data/Day12.txt | xargs -d '\n' ts-node src/Day12Task2.ts`  
Day 13 - Task 1: `go run src/Day13Task1.go data/Day13.txt`  
Day 13 - Task 2: `go run src/Day13Task2.go data/Day13.txt`  
Day 14 - Task 1: `g++ src/Day14Task1.cpp; cat data/Day14.txt | xargs ./a.out; rm -f a.out`  
Day 14 - Task 2: `g++ src/Day14Task2.cpp; cat data/Day14.txt | xargs ./a.out; rm -f a.out`  
Day 15 - Task 1: `TODO`  
Day 15 - Task 2: `TODO`  
Day 16 - Task 1: `dmd src/Day16Task1.d; ./Day16Task1 data/Day16.txt; rm -f Day16Task1 Day16Task1.o`  

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
javac 1.8.0_172  
java 1.8.0_172  
bash 3.2.57(1)-release  
erl 10.2  
erlc 10.2  
ts-node: 7.0.1  
go 1.11.2  
g++ 4.2.1  
TODO  
dmd 2.083.1  
