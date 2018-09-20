#include <stdio.h>
#include <sys/time.h>
//#include <math.h>	// has sqrt
//#include <tgmath.h>	// has sqrtl for long double square root
//#include <pthreads.h> // has multi-threading in C
#include <time.h> // has clock () function for timestamp. Has clock_t, clock, CLOCKS_PER_SEC
#define numTimeStamps 3	// The amount of benchmarking timestamps in the program
#defint numThreads 2	// The amount of CPU threads used to calculate primes
/*
* This program is a consecutive prime number finder. It finds all consecutive prime numbers from 2 to N and outputs them in order, as quickly as possible, using the fastest algorithms known to man (or woman)
*
*/

void sieve (long long int, unsigned long long int *);
unsigned long long int squareRoot (unsigned long long int);
unsigned long long int * primeArr;	// array that holds the primes
long long int numFound;	// Amount of primes found so far
clock_t timeStamps [numTimeStamps];	// list of timeStamps. Used to benchmark this code

int main (int argc, int ** argv) {
	timeStamps[0] = clock(); // Record when the program began. Record start time
	// Data Types:
	// long long int : %lli : at least 64 bit signed integer
	// unsigned long long int : %llu : at least 64 bit unsigned integer

	//unsigned long long int numPrimesToFind;
	long long int numPrimesToFind;

	if (argc < 2) {	// Read number of primes to find from user input while this program is running, with "scanf"
		printf (" Please enter the amount of primes to find: ");
		scanf ("%lli", &numPrimesToFind);
	} else {	// Read number of primes to calculate from command line argument that started and called findPrimes
		sscanf ((char *)argv[1], "%lli", &numPrimesToFind);
	}

	if (numPrimesToFind < 0) {
		printf("The amount of primes to find must be positive (%llu entered)\n", numPrimesToFind);
		return 1;
	}

	//printf("Finding %llu primes\n", numPrimesToFind);
	//printf("%llu Bytes will be used to store the primes\n", sizeof (long long int) * numPrimesToFind);

	unsigned long long int primes [numPrimesToFind];
	primeArr = primes;
	primes[0] = 2;
	primes[1] = 3;
	primes[2] = 5;
	primes[3] = 7;
	numFound = 4;	// initially, only these primes have been found
	sieve (numPrimesToFind, primes);
	// Note: Currently, the PowerShell command line doesn't print more than 259619 lines. There is probably a setting to adjust this.

	timeStamps[numTimeStamps - 1] = clock(); // Record program ending time
	
	// Print performance data:
	printf ("\n\n----------------------------------------------\nPERFORMANCE:\n----------------------------------------------\n Clock ticks per second: %li\n", CLOCKS_PER_SEC);
	for (int i = 0; i < numTimeStamps; i++) {
		printf ("\tTime stamp %d: %li clock ticks,\t\t%f seconds\n", i, timeStamps[i], ((float)timeStamps[i])/(float)CLOCKS_PER_SEC);
	}
	
	printf ("program time (clock ticks): %lli\n", (long long int)(timeStamps[numTimeStamps - 1] - timeStamps[0]));
	return 0;
}

//	ALGORITHM 1: SIEVE OF ERATOSTHENES
void sieve (long long int numPrimesToFind, unsigned long long int * primes) {
	long long int i = 0;	// i is the index in primes[] of the next prime to divide "candidate" by (to check if "candidate" is prime)


	//print all the primes we already have so far, that are less then numPrimes to find. numPrimesToPrint = minimum(numPrimesToFind, numFound):
	for (long long int numPrimesToPrint = numPrimesToFind < numFound? numPrimesToFind : numFound; i < numPrimesToPrint; i++) {
		printf ("primes[%lli] == %llu\n", i, primes[i]);
	}

	// If the correct amount of primes have been printed, then terminate
	if (i >= numPrimesToFind) {
		printf ("All %lli primes were already found previously\n", numPrimesToFind);
		return;
	}


	// When code gets here, numPrimesToFind >= numFound, and i == numFound
	unsigned long long int candidate = primes[numFound-1] + 2;	// Should be +1 if we are not skipping even numbers// check the number after the last known prime

	do {
		// CHECK IF "candidate" IS PRIME

		// TRIVIAL PRIME CHECKS:
		// ie: is the last bit 0? Do the last few bits guarantee that "candidate" is not prime?
		// ... insert trivial checks here ...
		
		// Sieve of Eratosthenes check:
		unsigned long long int upperBound = squareRoot(candidate);

		//printf ("Square root is: %llu\n", upperBound);
		//return;



		i = 1;


		// This function checks candidate against all primes in prime array less than sqrt (candidate), but does so using multiplication instead of sqrt. This is to save computations, but means that the multiplication must be done at each iteration of this loop
		/*
		do {

		} while ();
		*/

		// This function checks candidate against all primes in prime array less than sqrt (candidate)
		/*
		i = 1;
		unsigned long long int upperBound = (unsigned long long int ) ciel(sqrt(candidate));
		unsigned long long int
		do {

			i++;
		} while ( < upperBound);
		*/

		// This loop just checks candidate against all primes currently found in prime array
		//*
		for (i = /*0 if not skipping even*/1; primes[i] <= upperBound; i++) {	// only need to compare to primes less then sqrt(candidate)
			if (candidate % primes[i] == 0) {
				goto findNext;	// if candidate has a factor, it's not prime
			}
		}
		// when code gets here, primes[i] >= upperBound, and so candidate is prime
		//if (i == upperBound) {
			// Found a prime not in primes[]
			primes[numFound] = candidate;
			printf ("primes[%lli] == %llu\n", numFound, candidate);
			numFound++;
		//}
		//*/


		findNext:


		candidate += 2;	// increment by 2 to skip over even numbers
	} while (numFound < numPrimesToFind);

}

//TODO: Put integer square root code in a separate file

// MORE OPTIMIZATIONS TO DO:
// 1. Use multiple threads, and correctly use synchronization primitives for this (potential employers will love this).
// 2. When "square" is really big, we don't need to re-calculate the square root each time, because in integer math, roundDown(sqrt(big number)) == roundDown(sqrt(bigNumber + 1)).
//    So we could just check if the square root will be the same (with 1 multiplication), instead of re-calculating it.
// 3. Find a smarter way to pick the initial guess for Newton's method.
// 4. Find other, faster ways to check if a number is prime, which may filter out numbers that are obviusly not prime. Maybe this could involve checking certain bits?
// 5. Make each CPU thread check multiple prime candidates. Have a preprocessor macro for "Prime_Candidates_Per_Thread" to store the number of prime candidates that each CPU thread 
//    checks as it travels up the array of prime numbers. The benefit of checking multiple candidates on each prime array traversal is that those array indexes in primes[] will 
//    still be in the CPU cache when they are used to compare the next candidate. So instead of accessing a in index for only 1 prime candidate, and then not needing that index until
//    the next candidate comes, we can test several prime candidates against the same prime number at the same time. This can also make use of SSE instructions for Intel processors.


// Integer Square root. What it does: Finds the square root of an integer "square," rounded down to the nearest integer. Uses a form of Newton's method, where Pn+1 = (Pn + square/Pn)/2. quadratic convergence.
unsigned long long int squareRoot (unsigned long long int square) {
	//printf ("\n\nFinding the integer square root of: %llu\n", square);
	//return (unsigned long long int) math::sqrt((double)candidate);
	
	// OPTIMIZATION: Use a smaller initial guess, like x/2, or something (even though x/2 still grows linearly, it will be closer to sqrt(square))
	long long int x = square;	// this stores the "best guess" of root for this iteration. The initial guess is that the root equals the square
	long long int xPrev;	// this stores the previous value of x in the last iteration. This is used to check for convergence
	long long int i = 0;
	
	
	// Problem: When taking the square root of an integer "square," using the integer data type, there is not enough precision for Newton's method to converge.
	// This is because any integer data type is only accurate to within 1 integer. Any digits after the decimal point are cut off (mathematically same as setting to 0, round down to int).
	// This makes Newton's method (using only integers) not convergent for small numbers, because the approximation will not be accurate enough.
	// For example, if you try to take the square root of 8, using Newton's method [which is P(n+1) = (Pn + square/Pn)/2] but using only integer types, then the result will be as such:
	// x0 = 8, we are using the square, 8, as the initial guess.
	// x1 = (8 + 8/8)/2 = 4.5 in real math = 4 in integer math.
	// x2 = (4 + 8/4)/2 = 3.0 in reals = 3 in integers
	// x3 = (3 + 8/3)/2 = 2 in integers (since 8/3 evaluates to 2, and 5/2 evaluates to 2)
	// x4 = (2 + 8/2)/2 = 3 in integer math
	// x5 = (3 + 8/3)/2 = 2, and so the pattern repeats, and error never converges to less than 1 (which the loop needs to terminate).
	// Because of the inaccuracies of integer math, Newton's method does not converge to the desired accuracy when using only integers.
	// Solution 1: Multiply x by a power of 2, such as 2^(2*N), or shifting x left 2*N places. This will increase precision in taking the square root. This will be undone later after 
	// we compute the square root, by dividing by 2^N or shifting x right by N places. This works because sqrt(X) == sqrt(2^(2N)*X)/(2^N) 
	// Solution 2: Pre-compute the amount of iterations that it should take Newton's method to calculate the square root to within an error of 1. Round down (or up, when appropriate???)
	// Solution 3: Store the result of the last 2 iterations. Terminate the loop when the result of the iteration that just ran is equal to either of the iterations before it, and
	// This way, if the solution bounces "between" 2 solutions (an upper and lower bound for the square root, such as 2 and 3 in the example), then the program can pick the lower one 
	
	square = square << 4;
	do {
		xPrev = x;
		// Newton's Method. Also called "Babylonian", "Hero's" or "Heron's" method
		// x = (x + square/x)/2, or x = (x^2 + square)/2x
		x = (x + square/x)>>1;
		
		i++;
		//printf ("x%lli = %lli\n", i, x);
		
		/*
		* Stopping Condition:
		* 
		* We want the square root of "square", rounded down to the nearest whole integer.
		* This means that for exact root "P", and nth approximation of square root "Pn":
		* |Pn - P| < 1, this would be the ideal stopping conditon
		* However, since we don't know the exact P, we cannot use this as a stopping condition.
		* BUT, we do know that each iteration should get closer to P than the last, meaning that:
		* |Pn+1 - P| < |Pn - P|
		* So as Pn+1 and Pn get closer to P, then Pn+1 and Pn also get closer to each other. When Pn+1 = Pn to within 1, such that |Pn+1 - Pn| < 1,
		* THEN we can stop, because we know that Pn+1 and Pn must be within 1 of P.
		* We are assuming that IF |Pn+1 - Pn| < 1 THEN |Pn+1 - P| < |Pn - P| < 1
		* Since we are using integers anyway, then any operation we do is with an integer. Any divide operation rounds down to the nearest integer
		* Basically, we stop when more iterations no longer changes the result, because we assume that by then, we are within 1 of the root.
		*/
	} while (x != xPrev && i < 50);
	
	// Undo multiplying by power of 2. Since the square root has already been taken, we only need to shift half as much as we did before, to undo the shifting we did before 
	square = square >> 2;
	x = x >> 2;
	//printf ("square root is: %lli\n", x);
	return x;
}

/*
//	ALGORITHM 1: SIEVE OF ERATOSTHENES
//primes.length number of primes will be found
public static long[] primes = new long[1000]; // this will store all primes found.
public static int indexOfHighestPrime = 0;
static public boolean isNewPrime(long a){	// this is used in the sieve of Eratosthenes algorithm
	int i = 0;
	while (true){ // this loop will run until a is found to be a multiple of a prime (return false, not prime) or a is found to not
		//be a multiple of any primes
		//this code will now see if a is not a factor of any found primes. If it is, then a is not prime. If it isn't, a is prime
		if (a % primes[i] == 0 && primes[i] != 1 && a != primes[i]){//a is not prime if it is divisible by any number except 1 and "a"
			return false;
		}else{
			if (i == indexOfHighestPrime){
				//a is not of factor of any primes from primes[0] to primes[indexOfHighestPrime]. So A must be prime
				return true;
			}
		}

		++i;
	}
}
//	sieve of Eratosthenes algorithm
void sieve (unsigned long long int * primes) {
	primes[0] = 1;
	System.out.println("index\tprime");
	int a = 2;
	do{
		if (isNewPrime(a)){
			indexOfHighestPrime += 1; //Because indexOfHighestPrime is incremented here, there must be space for it in the array.
			primes[indexOfHighestPrime] = a;
			//System.out.println(indexOfHighestPrime + "\t" + a); // This is error checking code
		}
		a++;
	} while (indexOfHighestPrime < primes.length - 1); // The "-1" must be here so that there will be space in primes[] for the newest
	//prime when 1 more prime is added the next time the loop runs. The loop will only go if the index of highest prime is 1 less
	//than primes.length so that when the loop runs a final time, there is space for 1 more prime.


	//System.out.println("index\tprime");


	for (int b = 0; b < primes.length; b+= 1){//prints out all primes in array
		System.out.println(b + "\t" + primes[b]);
	}
}*/
