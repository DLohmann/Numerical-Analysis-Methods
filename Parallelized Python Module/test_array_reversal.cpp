#include <stdio.h>
#include "Array_Reversal.h"


void printArr (int * arr, int length) {
	int * ptr = arr;
	printf (" %d", *(ptr++));
	for (; ptr < arr + length; ptr++) {
		printf (", %d", *ptr);
	}
	printf("\n");
	
}

void testArr (int * arr, int length) {
	printf ("Array is:\n");
	printArr (arr, length);
	printf ("Reversed array is:\n");
	reverseArray (arr, length);
	printArr (arr, length);
	printf ("\n\n");
}

int main (int argc, char ** argv) {
	
	int arr [] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	int length = 10;
	
	testArr(arr, length);

	int * largeArr = new int [500];
	for (int i = 0; i < 500; i++) {
		//largeArr[500 - 1 - i] = i;
		largeArr[i] = i;
	}

	testArr(largeArr, 500);
	
	return 0;
}
