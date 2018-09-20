#include <stdio.h>
// ERROR: This doesn't work for sqrt(3) because integer rounding gives too much error for such small numbers. So doesn't converge
int main (int argc, int ** argv) {
	printf ("Square Root Using Newton's Method:\n");
	long long int square;
	if (argc < 2) {	// Read number to find square root of, from user input while this program is running, with "scanf"
		printf ("Please enter the number to find the square root of: ");
		scanf ("%lli", &square);
	} else {	// Read number to find square root of from command line argument when executable was called
		sscanf ((char *)argv[1], "%lli", &square);
	}

	if (square <= 0) {
		printf("The number to find the square root of must be a positive integer (%llu entered)\n", square);
		return 1;
	}

	printf ("Finding square root of %llu:\n", square);
	
	long long int x = square;	// this stores the "best guess" of root for this iteration. The initial guess is that the root equals the square
	long long int xPrev;	// this stores the previous value of x in the last iteration. This is used to check for convergence
	//long long int x2;	// x squared
	//long long int x3;	// x cubed
	long long int i = 0;
	
	do {
		xPrev = x;
		// Newton's Method. Also called "Babylonian", "Hero's" or "Heron's" method
		// x = (x + square/x)/2, or x = (x^2 + square)/2x
		x = (x + square/x)>>1;
		
		// Halley's method. A type of Househoulder method. Has cubic convergence, but doesn't always converge
		/*
		x2 = x*x;
		x3 = x2*x;
		x = (x3+(3*square*x))/(3*x2 + square);
		*/
		
		
		i++;
		printf ("x%lli = %lli\n", i, x);
		
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
	} while (x != xPrev);
	
	printf ("Square root of %lli is %lli\n", square, x);
	
	return 0;
}