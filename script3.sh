#!/bin/bash
# Description :	Compile and run all the variations of the algorithm witn the same inputs.


bison -d -v -r all myanalyzer.y
flex mylexer.l
gcc -o mycomp myanalyzer.tab.c lex.yy.c cgen.c -lfl
./mycomp < correct3.ms > correct3out.c

gcc -Wall -std=c99 -o cor3 correct3out.c

echo -e "\n\nPROGRAM\n" 
./cor3
echo -e "\n" 