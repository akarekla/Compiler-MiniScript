#!/bin/bash
# Description :	Compile and run all the variations of the algorithm witn the same inputs.


bison -d -v -r all myanalyzer.y
flex mylexer.l
gcc -o mycomp myanalyzer.tab.c lex.yy.c cgen.c -lfl
./mycomp < correct2.ms > correct2out.c

gcc -Wall -std=c99 -o cor2 correct2out.c

echo -e "\n\nPROGRAM\n" 
./cor2
echo -e "\n" 