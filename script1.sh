#!/bin/bash
# Description :	Compile and run all the variations of the algorithm witn the same inputs.


bison -d -v -r all myanalyzer.y
flex mylexer.l
gcc -o mycomp myanalyzer.tab.c lex.yy.c cgen.c -lfl
./mycomp < correct1.ms > correct1out.c

gcc -Wall -std=c99 -o cor1 correct1out.c

echo -e "\n\nPROGRAM\n" 
./cor1
echo -e "\n" 