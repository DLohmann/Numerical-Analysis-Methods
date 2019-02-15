#include <iostream>
#include "mathlib.h"

using namespace std;

int main () {
	cout << "Creating matrices" << endl;

	matrix A(3, 4);

	cout << "numRows: " << A.numRows() << ", numCols: " << A.numCols() << endl;




	/*
	matrix A (3, 3) = {
		{1, 0, 0},
		{0, 1, 0},
		{0, 0, 1}
	};

	matrix B = {
		{1},
		{2},
		{3}
	};
	*/

	//cout << "Testing dot product" << endl;


	return 0;
}