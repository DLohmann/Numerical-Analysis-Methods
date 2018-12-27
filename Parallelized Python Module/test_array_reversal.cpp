#include <stdio.h>	// has printf, perror
#include <string.h> // Has memcpy
#include <stdlib.h>	// has rand()
#include "Array_Reversal.h"

//#define debug_test_statements

void printArr (int * arr, int length) {
	int * ptr = arr;
	printf (" %d", *(ptr++));
	for (; ptr < arr + length; ptr++) {
		printf (", %d", *ptr);
	}
	printf("\n");
	
}

void testArr (int * arr, int length) {
	// Make a copy of the original
	int arrOriginal [length];
	memcpy(arrOriginal, arr, length*sizeof(int));
	#ifdef debug_test_statements
		printf ("\nArray is:\n");
		printArr (arr, length);
		printf ("Reversed array is:\n");
	#endif
	reverseArray (arr, length);
	#ifdef debug_test_statements
		printArr (arr, length);
	#endif

	// Check if the array was reversed correctly
	for (int i = 0; i < length; i++) {
		if (arrOriginal[i] != arr[length - 1 - i]) {
			fprintf(stderr, "Error: Incorrect reversal: Item %d at index %d in original array is not the same as item %d at index %d in reversed array.\n", arrOriginal[i], i, arr[length - 1 - i], length - 1 - i);
			exit(0);
		}
	}

	printf ("Success!\n\n");
}

int main (int argc, char ** argv) {
	printf ("***** TESTING REVERSE ARRAY *****\n");
	
	printf ("Test of length 10: ");
	int arr1 [] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	int length1 = 10;
	testArr(arr1, length1);

	printf ("Test of length 9: ");
	int arr2 [] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
	int length2 = 9;
	testArr(arr2, length2);
	
	printf ("Test of length 500: ");
	int * largeArr = new int [500];
	for (int i = 0; i < 500; i++) {
		//largeArr[500 - 1 - i] = i;
		largeArr[i] = i;
	}
	testArr(largeArr, 500);
	delete[] largeArr;

	printf ("Fuzz test: 10 random test cases of length 0-10:\n");
	for (int i = 0; i < 10; i++) {
		// Test a single case
		printf ("Test %d: ", i);
		int length = rand()%10;
		int * arrPtr = new int [length];
		// Populate the array with random elements
		for (int k = 0; k < length; k++) {
			arrPtr[k] = rand();
		}

		// Test the reversal:
		testArr (arrPtr, length);

		delete[] arrPtr;
		
	}
	return 0;
}
