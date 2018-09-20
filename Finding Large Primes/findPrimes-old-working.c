#include <stdio.h>
#include <math.h>	// has sqrt
//#include <tgmath.h>	// has sqrtl for long double square root
//#include <pthreads.h> // has multi-threading in C

void sieve (long long int, unsigned long long int *);
unsigned long long int squareRoot (unsigned long long int);

unsigned long long int * primeArr;	// array that holds the primes
long long int numFound;	// Amount of primes found so far

int main (int argc, int ** argv) {

	//Data Types:
	// long long int : %lli : at least 64 bit signed integer
	// unsigned long long int : %llu : at least 64 bit unsigned integer

	//unsigned long long int numPrimesToFind;
	long long int numPrimesToFind;

	if (argc < 2) {	// Read number of primes to find from user input while this program is running, with "scanf"
		printf (" Please enter the amount of primes to find:\n");
		scanf ("%lli", &numPrimesToFind);
	} else {	// Read number of primes to calculate from command line argument that started and called findPrimes
		sscanf ((char *)argv[1], "%lli", &numPrimesToFind);
	}

	if (numPrimesToFind < 0) {
		printf("The amount of primes to find must be positive (%llu entered)\n", numPrimesToFind);
		return 1;
	}

	printf ("Finding %llu primes\n", numPrimesToFind);
	printf("%llu Bytes will be used to store the primes\n", sizeof (long long int) * numPrimesToFind);

	unsigned long long int primes [numPrimesToFind];
	primeArr = primes;
	primes[0] = 2;
	primes[1] = 3;
	numFound = 2;	// initially, only these 2 primes have been found
	sieve (numPrimesToFind, primes);



	return 0;
}

//	ALGORITHM 1: SIEVE OF ERATOSTHENES
void sieve (long long int numPrimesToFind, unsigned long long int * primes) {
	long long int i = 0;	// i is the index in primes[] of the next prime to divide "candidate" by (to check if "candidate" is prime)


	//print all the primes we already have so far:
	for (long long int numPrimesToPrint = numPrimesToFind < numFound? numPrimesToFind : numFound; i < numPrimesToPrint; i++) {
		printf ("primes[%lli] == %llu\n", i, primes[i]);
	}

	// If all the correct amount of primes are already printed, then terninate
	if (i >= numPrimesToFind) {
		printf ("All %lli primes were already found previously\n", numPrimesToFind);
		return;
	}


	// When code gets here, numPrimesToFind >= numFound, and i == numFound
	unsigned long long int candidate = 3;

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
		for (i = 1; i < numFound; i++) {	// only need to compare to primes less then sqrt(candidate)
			if (candidate % primes[i] == 0) {
				break;
			}
		}
		if (i == numFound) {
			// Found a prime not in primes[]
			primes[i] = candidate;
			numFound++;
			//printf ("primes[%lli] == %llu\n", i, candidate);
		}
		//*/





		candidate += 2;
	} while (numFound < numPrimesToFind);

}

unsigned long long int squareRoot (unsigned long long int num) {
	//return (unsigned long long int) math::sqrt((double)candidate);
	return num;
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
