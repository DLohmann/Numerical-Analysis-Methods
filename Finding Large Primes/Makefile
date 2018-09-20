#!/usr/bin/bash
all:
#-std=c99 is required to declare a counter variable in condition of for loop: for (int i =...
#-O3 is the optimization level
#gcc -std=c99 -O3 findPrimes.c -o findPrimes
	gcc -std=c99 findPrimes.c -lpthread -o findPrimes
clean:
	rm findPrimes
