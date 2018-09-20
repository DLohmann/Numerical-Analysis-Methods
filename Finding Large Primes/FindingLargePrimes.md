# Finding Large Primes

This folder is dedicated to finding large primes.

## Stuff To Do: 
-----------------------------------------

### ORGANIZATION:
 1. Put integer square root code in a separate file.
 2. Put findPrimes() in a separate file, and make it a C library that can be pre-complied and used with the Makefile.
 3. Use CMake to generate makefiles. This will enable Makefiles for different systems.
 4. Include command line options to choose what output to include:
    -s option for silent operation (no output?)
	-p option to print all primes
	-l option to print only the last prime (mutually exclusive with -p option)
 5. Create a man page for this file's documentation.
 6. Make this program callable from Python with Python.h, using the CPython Python interpreter.

### OPTIMIZATION:
 1. Use multiple threads, and correctly use synchronization primitives for this (potential employers will love this).
 2. When "square" is really big, we don't need to re-calculate the square root each time, because in integer math, roundDown(sqrt(big number)) == roundDown(sqrt(bigNumber + 1)).
    So we could just check if the square root will be the same (with 1 multiplication), instead of re-calculating it.
 3. Find a smarter way to pick the initial guess for Newton's method.
 4. Find other, faster ways to check if a number is prime, which may filter out numbers that are obviously not prime. Maybe this could involve checking certain bits?
 5. Make each CPU thread check multiple prime candidates. Have a preprocessor macro for "Prime_Candidates_Per_Thread" to store the number of prime candidates that each CPU thread 
    checks as it travels up the array of prime numbers. The benefit of checking multiple candidates on each prime array traversal is that those array indexes in primes[] will 
    still be in the CPU cache when they are used to compare the next candidate. So instead of accessing a in index for only 1 prime candidate, and then not needing that index until
    the next candidate comes, we can test several prime candidates against the same prime number at the same time. This can also make use of SSE instructions for Intel processors.
 6. Ensure Makefile uses the gcc compiler's highest level of optimization.
 7. Ensure that primes are stored as dynamic memory (heap) instead of stack, and freed at end of program. This is so it can store more memory
 
### INTERESTING FINDINGS:
 1. In the Ubuntu bash shell for Windows 10 (in PowerShell with "bash" command), "findPrimes-old-working.c" crashes with a segmentation fault if the number of primes is over a certain 
    amount. It works with 1047523 primes (using 8380184 bytes to hold the 64 bit primes), but fails with 1047524 primes (using 8380192 bytes). This probably has to do with the size of 
	the primes. I suspect that the stack does not let more than 2^23 bytes for all the memory used by the program, or something similar to this.
    But in Windows 10's PowerShell, the number of primes can be up to 10^16 without crashing. So it seems that in Ubuntu Linux, there is a certain limit on the amount of memory that
	can be stored in local variables (on the program stack).
 2. A function can be used to call a thread multiple times??? So even after a thread has been finished, it can be called again later with a function??? Thats what this indicates:    
    https://www.geeksforgeeks.org/multithreading-c-2/ . In C++, there is also an STL threads library.
 3. Some more useful pthreads multi-threading documentation: https://www.cs.cmu.edu/afs/cs/academic/class/15492-f07/www/pthreads.html
 4. Could hardware interrupts be used for thread synchronization to make the program more efficient? http://users.ece.utexas.edu/~valvano/Volume1/E-Book/C12_Interrupts.htm

