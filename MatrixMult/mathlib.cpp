#ifndef mathlib_c
#include "mathlib.h"
#include <stdio.h>
#include <iostream>
//#include <stdexcept>	// used for error checking

// ********** CONSTRUCTORS **********
// input: Number of rows (M) and columns (N).
// ouput: a matrix of zeros, that are doubles
matrix::matrix (int M, int N) : std::vector<double>(M, std::vector<double>(N, 0)) {
	//std::vector<std::vector<double>> m(3, std::vector<double>(4));
	//super(M)
	printf("matrix constructor called!\n");
}

int matrix::numRows () {
	return size();
}
int matrix::numCols () {
	return this[0].size();
}

// find the determinant
//double det();
// idea: override the assignment operator for the matrix, to keep a boolean to check if there were any changes since the last determinant was calculated
// if the matrix was not changed since the last det() function was called, then there is no need to re-calculate the determinant; just use the old calculated value
// but we wil need a boolean to check if it has been changed


// 
void operator*= (matrix& A, matrix& B) {
	// check if the matrix dimensions are compatible
	if (A.numCols() != B.numRows()) {

		//char[] message;
	
		//sprintf("matrix dimensions do not allow multiplication (A.numCols() = %d, B.numRows() = %d)", A.numCols(), B.numRows() )
		std::cerr << "matrix dimensions do not allow multiplication (A.numCols() = " << A.numCols() << ", B.numRows() = " << B.numRows() << ")" <<std::endl;

		//throw std::invalid_argument("Bad parameters");
	}

	//for (int m = 0;) {
	//	for () {

	//	}const
	//}
	return matrix(0, 0);
}

// creates a new matrix, and calls operator*=
matrix operator* (matrix&, matrix&) {

}


#endif